#!/usr/bin/bash
set -e

echo "############## validando se arquivo .tfstate existe"
aws s3api head-object --bucket brunoluz-terraform-states-control --key githubactions-terraform-aws/dev/terraform.tfstate || not_exist=true
if [[ ! $not_exist ]]; then
  echo "############## fazendo download .tfstate"
  aws s3 cp s3://brunoluz-terraform-states-control/githubactions-terraform-aws/dev/terraform.tfstate .
fi

echo "############## terraform init"
terraform init

echo "############## terraform validate -no-color"
terraform validate -no-color

echo "############## terraform plan -no-color -var "prefix=dev" -lock=false"
terraform plan -no-color -var "prefix=dev" -lock=false

echo "############## apply -auto-approve -var "prefix=dev" -lock=false"
terraform apply -auto-approve -var "prefix=dev" -lock=false

echo "############## atualizando .tfstate"
aws s3 cp terraform.tfstate s3://brunoluz-terraform-states-control/githubactions-terraform-aws/dev/terraform.tfstate