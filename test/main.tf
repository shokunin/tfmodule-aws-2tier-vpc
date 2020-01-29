provider "aws" {
  region  = "us-east-1"
  profile = "redislabs"
}

module "awx" {
  source         = "../"
  profile        = "redislabs"
  region         = "us-east-1"
  vpc-name       = "rltest1"
  vpc-cidr       = "10.0.0.0/16"
  enable-private = false
  vpc-azs        = ["us-east-1a", "us-east-1b"]
  common-tags = {
    "Owner"   = "maguec"
    "Project" = "example"
  }
}
