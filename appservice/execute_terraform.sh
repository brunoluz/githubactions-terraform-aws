#!/usr/bin/bash
set -e

aws s3api head-object --bucket brunoluz-terraform-states-control --key githubactions-terraform-aws/dev/terraform.tfstate || not_exist=true
if [[ ! $not_exist ]]; then
  aws s3 cp s3://brunoluz-terraform-states-control/githubactions-terraform-aws/dev/terraform.tfstate .
fi
terraform init
terraform validate -no-color
terraform plan -no-color -var "prefix=dev" -lock=false
terraform apply -auto-approve -var "prefix=dev" -lock=false
aws s3 cp terraform.tfstate s3://brunoluz-terraform-states-control/githubactions-terraform-aws/dev/terraform.tfstate