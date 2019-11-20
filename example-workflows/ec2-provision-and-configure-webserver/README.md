# Installs apache to an EC2 instance on AWS with bolt and provision with terraform

This sample workflow installs apache on an EC2 instance on AWS. The workflow provisions the EC2 instance with a security group to AWS with terraform, the terraform state will be stored in a S3 bucket.

## Prerequisites
Before you run the workflow, make sure you have access to the following:
- An AWS account that has the privilege to create a S3 bucket, an EC2 instance and a security group
An AWS VPC where u want to deploy your setup
A SSH key to connect to the EC2 instance (create or upload it to AWS)


## Run the workflow
Follow these steps to run the workflow:
1. Add your AWS account to the workflow as a secret.
   1. Click **Edit > Secrets.**
   2. Click **Define new secret** and use the following values:
      - **KEY:** credentials
      - **VALUE:** Enter your base64 encoded AWS account
      
      Example:  
      [default]  
      aws_access_key_id = RANDOMKEY  
      aws_secret_access_key = RANDOMKEY  
      
      Encode with base64:
      W2RlZmF1bHRdCmF3c19hY2Nlc3Nfa2V5X2lkID0gUkFORE9NS0VZCmF3c19zZWNyZXRfYWNjZXNzX2tleSA9IFJBTkRPTUtFWQ==

2. Add your ssh key for bolt as a secret.
   1. Click **Edit > Secrets.**
   2. Click **Define new secret** and use the following values:
      - **KEY:** id_rsa
      - **VALUE:** Enter your private key content
      
      Example:
      -----BEGIN RSA PRIVATE KEY-----
      RANDOMSTRING
      -----END RSA PRIVATE KEY-----

3. Configure your workflow parameters.
   1. Click **Run** and enter the following parameters:
      - **git_repository:** Enter the git repository where files are located
      - **aws_region:** Enter the AWS region you want to use
      - **ssh_key_name:** Enter the AWS ssh key name can be found in the AWS console and is set when you create/upload your key to AWS
      - **terraform_state_bucket:** The name of the S3 Storage bucket where Terraform stores its state. The name must be globally unique.
      - **vpc_id:** Enter the AWS vpc id where you want to provision your EC2 instance
    
4. Click **Run workflow** and wait for the workflow run page to appear.

## Open your webserver in a browser
To find the URL for your webserver:
1. From the nebula console, click **logs** tab and select the provision-ec2-with-terraform step to see your EC2 ip.
2. Copy the ip and paste into a browser.

Congratulations! You've installed apache to an EC2 using Puppet Bolt and Terraform.

<p align="center"><img src="./ec2-provision-and-configure-webserver.png" /></p>
