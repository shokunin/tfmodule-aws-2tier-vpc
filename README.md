# A module to build a 2 tier VPC

## Prerequisites

- aws-cli
- tfenv

## Generate Key Pair

```
aws ec2 create-key-pair --profile redislabs --key-name maguec1 --region us-west-1 \
| jq .KeyMaterial |  awk '{gsub(/\\n/,"\n")}1' | \
sed -e s/\"//g >> ~/.ssh/maguec1.pem

chmod 0600 ~/.ssh/maguec1.pem
```

This keypair name should match the name of the VPC

## Example usage

```
provider "aws" {
  region  = var.region
  profile = var.profile
}

module "vpc" {
  source         = "git@github.com:shokunin/tfmodule-aws-2tier-vpc?ref=master"
  region         = var.region
  profile        = var.profile
  vpc-name       = var.vpc-name
  vpc-cidr       = var.vpc-cidr
  vpc-azs        = var.vpc-azs
  enable-private = false
  common-tags = {
    "Owner"   = "maguec"
    "Project" = "example_terraform"
  }
}
```


