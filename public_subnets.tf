resource "aws_subnet" "public" {
  count                   = "${length(var.vpc-azs)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${cidrsubnet(var.vpc-cidr, length(var.vpc-azs) * 2, count.index)}"
  availability_zone       = "${var.vpc-azs[count.index]}"
  map_public_ip_on_launch = "${var.map-public-ip-on-launch}"
  tags                    = merge({ Name = "${var.vpc-name}-public-${element(var.vpc-azs, count.index)}" }, var.common-tags)
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${element(aws_route_table.public_route_table.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.vpc.id}"
  count                  = "${length(var.vpc-azs)}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.vpc-azs)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public_route_table.*.id, count.index)}"
}

resource "aws_route_table" "public_route_table" {
  count  = "${length(var.vpc-azs)}"
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = merge({ Name = "${var.vpc-name}-public-${element(var.vpc-azs, count.index)}" }, var.common-tags)
}
