# Step-by-Step Guide:

1. Initialize Terraform
Navigate to the specific environment directory (e.g., environments/dev) and run the following command to initialize Terraform:

```sh
    terraform init
```
This command initializes the backend and downloads the necessary provider plugins.

2. Plan the Changes
Run the following command to create an execution plan. This command will show you what changes will be made without actually applying them:

```sh
    terraform plan -var-file="../../variables/dev.tfvars"
```

Replace dev.tfvars with the appropriate variable file for other environments (e.g., testing.tfvars, staging.tfvars, prod.tfvars).

3. Apply the Changes
Execute the following command to apply the changes and provision the infrastructure:

```sh
    terraform apply -var-file="../../variables/dev.tfvars"
```
Replace dev.tfvars with the appropriate variable file for other environments.