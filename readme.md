# Classes

install terraform

https://learn.hashicorp.com/tutorials/terraform/install-cli

configure your provider

```hcl
provider "aws" {
  region = "us-east-1"
   profile = "lets"
}
```
https://registry.terraform.io/providers/hashicorp/aws/latest/docs


execute your code

```shell
terraform init
```

```shell
terraform plan
```

```shell
terraform apply
```