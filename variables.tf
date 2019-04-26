variable "vpc-name" {
  description = "The name of the VPC eg: maguetest"
}

variable "profile" {
  description = "The AWS profile to use"
}

variable "region" {
  description = "The AWS region to run in"
}

variable "vpc-cidr" {
  description = "The network CIDR to use for the VPC"
}

variable "enable-vpc-dns" {
  description = "Enable vpc dns"
  default     = true
}

variable "map-public-ip-on-launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address."
  default     = "false"
}

variable "vpc-azs" {
  type        = list(string)
  description = "The list of approved azs eg: ['us-west-1a', 'us-west-1c']"
}

variable "common-tags" {
  type        = map(string)
  description = "Tags that go everywhere"
}

variable "enable-private" {
  description = "Enable Private Networks"
  default     = true
}
