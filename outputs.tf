output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "vpc-cidr" {
  value = var.vpc-cidr
}

output "subnets-public" {
  value = aws_subnet.public[*].id
}

output "vpc-azs" {
  value = var.vpc-azs
}

#output "subnets-private" {
#  value = ["${aws_subnet.private.*.id}"]
#}
#output "private-nats" {
#  value = ["${aws_eip.private-nat-eip.*.public_ip}"]
#}
