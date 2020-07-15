# Terraform - share code between multiple environments

Share Terraform code between Dev and Prod environments where the variables different between environments are set in `dev.tfvars` and `prod.tfvars`, and common variables are set as defaults in `variables.tf`.

This repo is a slight modification of [Separate Development and Production Environments](https://learn.hashicorp.com/terraform/modules/tf-code-management) at HashiCorp Learn.


## References:
[Workspaces]https://www.terraform.io/docs/state/workspaces.html


## Run the code

### Navigate to the directory
`cd learn-terraform-code-organization`

### Initialize your Terraform project
`terraform init`

### See the list of your workspaces (only `default` workspace initially)
`terraform workspace list`

### Create a new `dev` workspace, and switch to it
#### Note: any previous state files from your default workspace are hidden from your dev workspace
`terraform workspace new dev`

### Apply the configuration for `dev` environment
`terraform apply -var-file=dev.tfvars`

### The same for `prod` environment
`terraform workspace new prod`
`terraform apply -var-file=prod.tfvars`

### Destroy workspace deployments
`terraform workspace select dev`
`terraform destroy -var-file=dev.tfvars`

`terraform workspace select prod`
`terraform destroy -var-file=prod.tfvars`

### State storage in workspaces
- When there is only a `default` workspace, `terraform.tfstate` file is stored in the root directory of the project.
- When there are additional workspaces, Terraform internals manage and store state files in the directory `terraform.tfstate.d` at the project root.

#### Directory tree
```.
├── README.md
├── assets
│   └── index.html
├── dev.tfvars
├── main.tf
├── outputs.tf
├── prod.tfvars
├── terraform.tfstate.d
│   ├── dev
│   │   └── terraform.tfstate
│   ├── prod
│   │   └── terraform.tfstate
├── terraform.tfvars
└── variables.tf
```



