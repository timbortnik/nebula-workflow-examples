terraform {
  required_version = ">= 0.11.11"
  backend "gcs" {}
}

provider "google" {
  credentials = "${var.google-credentials}"
  project     = "${local.workspace["gcp_project"]}"
  region      = "${local.workspace["gcp_region"]}"

  scopes = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    "https://www.googleapis.com/auth/devstorage.full_control",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

resource "google_container_cluster" "k8scluster" {
  name               = "k8scluster"
  description        = "Kubernetes cluster"
  location           = "${local.workspace["gcp_location"]}"
  initial_node_count = "${var.initial_node_count}"

  master_auth {
    username = ""

    client_certificate_config {
      issue_client_certificate = true
    }
  }

  node_config {
    machine_type = "${var.node_machine_type}"
    disk_size_gb = "${var.node_disk_size}"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/userinfo.email"
    ]
  }
}

data "google_client_config" "current" {}

data "google_client_openid_userinfo" "current" {}

data "google_service_account" "current" {
  account_id = split("@", data.google_client_openid_userinfo.current.email)[0]
  project    = split(".", split("@", data.google_client_openid_userinfo.current.email)[1])[0]
}

provider "kubernetes" {
  alias   = "app-cluster-primary"
  version = "~> 1.8.0"

  load_config_file = false

  host                   = "https://${google_container_cluster.k8scluster.endpoint}"
  cluster_ca_certificate = "${base64decode(google_container_cluster.k8scluster.master_auth.0.cluster_ca_certificate)}"

  token = "${data.google_client_config.current.access_token}"
}

resource "kubernetes_cluster_role_binding" "app-cluster-admin-cluster-role-binding" {
  provider = "kubernetes.app-cluster-primary"

  metadata {
    name = "terraform-cluster-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = "${data.google_service_account.current.email}"
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = "${data.google_service_account.current.unique_id}"
  }
}
resource "kubernetes_service_account" "app-helm-client" {
  provider = "kubernetes.app-cluster-primary"

  metadata {
    name      = "app-helm-client"
    namespace = "kube-system"

    labels = {
      "app.kubernetes.io/name"       = "helm-client"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  depends_on = [
    "kubernetes_cluster_role_binding.app-cluster-admin-cluster-role-binding"
  ]
}

resource "kubernetes_cluster_role_binding" "app-helm-client" {
  provider = "kubernetes.app-cluster-primary"

  metadata {
    name = "app-helm-client"

    labels = {
      "app.kubernetes.io/name"       = "helm-client"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    api_group = ""
    kind      = "ServiceAccount"
    name      = "${kubernetes_service_account.app-helm-client.metadata.0.name}"
    namespace = "${kubernetes_service_account.app-helm-client.metadata.0.namespace}"
  }
}

data "kubernetes_secret" "app-helm-client-default-secret" {
  provider = "kubernetes.app-cluster-primary"

  metadata {
    name      = "${kubernetes_service_account.app-helm-client.default_secret_name}"
    namespace = "kube-system"
  }
}