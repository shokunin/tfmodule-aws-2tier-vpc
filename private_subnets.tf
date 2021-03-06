resource "aws_subnet" "private" {
  count             = local.count_private
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(var.vpc-cidr, length(var.vpc-azs) * 2, count.index + length(var.vpc-azs))}"
  availability_zone = "${var.vpc-azs[count.index]}"
  tags              = merge({ Name = "${var.vpc-name}-private-${element(var.vpc-azs, count.index)}" }, var.common-tags)
}

resource "aws_eip" "private-nat-eip" {
  count      = local.count_private
  vpc        = true
  tags       = merge({ Name = "${var.vpc-name}-nat-eip-${count.index}" }, var.common-tags)
  depends_on = ["aws_internet_gateway.vpc"]
}

resource "aws_nat_gateway" "private" {
  count         = local.count_private
  allocation_id = "${element(aws_eip.private-nat-eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  depends_on    = ["aws_internet_gateway.vpc"]
  tags          = merge({ Name = "${var.vpc-name}-private-${element(var.vpc-azs, count.index)}" }, var.common-tags)
}

resource "aws_route" "nat_gateway" {
  count                  = local.count_private
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.private.*.id, count.index)}"
}

resource "aws_route_table" "private" {
  count  = local.count_private
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = merge({ Name = "${var.vpc-name}-private-${element(var.vpc-azs, count.index)}" }, var.common-tags)
}
