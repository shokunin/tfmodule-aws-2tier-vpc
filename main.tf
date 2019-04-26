provider "aws" {
  region  = var.region
  profile = var.profile
}

# Allow us to disable the private networks
locals {
  count_private = (var.enable-private == true ? length(var.vpc-azs) : 0)
}
