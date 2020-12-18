# create the VPC
resource "aws_vpc" "ag_test" {
  cidr_block           = var.vpcCIDRblock
#  instance_tenancy     = "${var.instanceTenancy}"
#  enable_dns_support   = "${var.dnsSupport}"
#  enable_dns_hostnames = "${var.dnsHostNames}"
  tags = {
    Name = var.tag
  }
} # end resource

# create the main Subnet
resource "aws_subnet" "ag_test" {
  vpc_id                  = aws_vpc.ag_test.id
  cidr_block              = var.subnetCIDRblock
  tags = {
    Name = "${var.tag}_subnet"
  }
} # end resource

# Create the Security Group
resource "aws_security_group" "ag_test" {
  vpc_id      = aws_vpc.ag_test.id
  name        = "${var.tag} Security Group"
  description = "${var.tag} Security Group"
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  # allow egress ephemeral ports
  egress {
    protocol    = "tcp"
    cidr_blocks = [var.destinationCIDRblock]
    from_port   = 1024
    to_port     = 65535
  }
  tags = {
    Name = "${var.tag}_security_group"
  }
} # end resource

# Create the Internet Gateway
/* resource "aws_internet_gateway" "ag_tfe_GW" {
  vpc_id = "${aws_vpc.ag_tfe.id}"
  tags = {
    Name = "${var.tag}_internet_gateway"
  }
} # end resource

# Create the Route Table
resource "aws_route_table" "ag_tfe_route_table" {
  vpc_id = "${aws_vpc.ag_tfe.id}"
  tags = {
    Name = "${var.tag}_route_table"
  }
} # end resource

# Create the Internet Access
resource "aws_route" "ag_tfe_internet_access" {
  route_table_id         = "${aws_route_table.ag_tfe_route_table.id}"
  destination_cidr_block = "${var.destinationCIDRblock}"
  gateway_id             = "${aws_internet_gateway.ag_tfe_GW.id}"
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "ag_tfe_association" {
  subnet_id      = "${aws_subnet.ag_tfe_Subnet.id}"
  route_table_id = "${aws_route_table.ag_tfe_route_table.id}"
} # end resource
*/