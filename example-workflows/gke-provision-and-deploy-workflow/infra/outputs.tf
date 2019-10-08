output "k8s_endpoint" {
  value = "https://${google_container_cluster.k8scluster.endpoint}"
}

output "k8s_master_auth_cluster_ca_certificate" {
  value = "${google_container_cluster.k8scluster.master_auth.0.cluster_ca_certificate}"
}

output "k8s_current_access_token" {
  value = "${lookup(data.kubernetes_secret.app-helm-client-default-secret.data, "token")}"
}