<h1>Installs apache to an EC2 instance on AWS with bolt and provision with terraform</h1>

<p>This sample workflow installs apache on an EC2 instance on AWS. The workflow provisions the EC2 instance with a security group to AWS with terraform, the terraform state will be stored in a S3 bucket.</p>

<h2>Prerequisites</h2>
<p>Before you run the workflow, make sure you have access to the following:</p>
<ul>
<li>An AWS account that has the privilege to create a S3 bucket, an EC2 instance and a security group</li>
<li>An AWS VPC where u want to deploy your setup</li>
<li>A SSH key to connect to the EC2 instance (create or upload it to AWS)</li>
</ul>

<h2>Run the workflow</h2>
<p>Follow these steps to run the workflow:</p>
<ol>
<li>Add your AWS account to the workflow as a secret.</li>
<ul>
    <li>Click <strong>Edit > Secrets.</strong></li>
    <li>Click <strong>Define new secret</strong> and use the following values:</li>
    <ul>
        <li><strong>KEY:</strong> credentials</li>
        <li><strong>VALUE:</strong> Enter your base64 encoded AWS account</li>
    </ul>
        </br><p>Example:</p>
        [default]</br>
        aws_access_key_id = RANDOMKEY</br>
        aws_secret_access_key = RANDOMKEY</br>
        </br><p>Encode with base64:</p>
        W2RlZmF1bHRdCmF3c19hY2Nlc3Nfa2V5X2lkID0gUkFORE9NS0VZCmF3c19zZWNyZXRfYWNjZXNzX2tleSA9IFJBTkRPTUtFWQ==
</ul>
</br>
<li>Add your ssh key for bolt as a secret.</li>
<ul>
    <li>Click <strong>Edit > Secrets.</strong></li>
    <li>Click <strong>Define new secret</strong> and use the following values:</li>
    <ul>
        <li><strong>KEY:</strong> id_rsa</li>
        <li><strong>VALUE:</strong> Enter your private key content</li>
    </ul>
        </br><p>Example:</p>
        -----BEGIN RSA PRIVATE KEY-----</br>
        RANDOMSTRING</br>
        -----END RSA PRIVATE KEY-----
</ul>
</br>
<li>Configure your workflow parameters.</li>
<ul>
    <li>Click <strong>Run</strong> and enter the following parameters:</li>
    <ul>
        <li><strong>git_repository:</strong> Enter the git repository where files are located</li>
        <li><strong>aws_region:</strong> Enter the AWS region you want to use</li>
        <li><strong>ssh_key_name:</strong> Enter the AWS ssh key name can be found in the AWS console and is set when you create/upload your key to AWS</li>
        <li><strong>terraform_state_bucket:</strong> The name of the S3 Storage bucket where Terraform stores its state. The name must be globally unique.</li>
        <li><strong>vpc_id:</strong> Enter the AWS vpc id where you want to provision your EC2 instance</li>
    </ul>
</ul>
</br>
<li>Click <strong>Run workflow</strong> and wait for the workflow run page to appear.</li>
</ol>

<h2>Open your webserver in a browser</h2>
<p>To find the URL for your webserver:</p>
<ol>
<li>From the nebula console, click <strong>logs</strong> tab and select the provision-ec2-with-terraform step to see your EC2 ip.</li>
<li>Copy the ip and paste into a browser.</li>
</ol>
<p>Congratulations! You've installed apache to an EC2 using Puppet Bolt and Terraform.</p>
<p align="center">
<img src="ec2-provision-and-configure-webserver.png" />
</p>
