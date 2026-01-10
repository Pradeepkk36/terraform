
## How to Use This Configuration:
Prerequisites:

Install Terraform (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

Install Google Cloud SDK (https://cloud.google.com/sdk/docs/install)

Authenticate with GCP (gcloud auth application-default login)

# Initialize Terraform:
-- terraform init

# Review the execution plan:
-- terraform plan

# Apply the configuration:
-- terraform apply

# Destroy resources when done:
-- terraform destroy

### Customization Options:
Change the machine_type to other GCP machine types like:

"n1-standard-1" (1 vCPU, 3.75GB RAM)

"e2-micro" (free tier eligible)

"e2-standard-2" (2 vCPUs)

Change the image to other OS images like:

"ubuntu-os-cloud/ubuntu-2204-lts"

"centos-cloud/centos-7"

"windows-cloud/windows-2019"

Add additional disks or configure GPU accelerators if needed

Remember to replace "your-project-id" with your actual GCP project ID before running this configuration.