# The default provider configuration; resources that begin with `aws_` will use
# it as the default, and it can be referenced as `aws`.
provider "aws" {
  region = var.region1
}

# Additional provider configuration for west coast region; resources can
# reference this as `aws.west`.
provider "aws" {
  alias  = "region2"
  region = var.region2
}

# Deploy VPC

# Deploy peer

# Get the AMI in region 1
data "aws_ami" "ubuntu-18_04-region1" {
  most_recent = true
  owners = ["${var.ubuntu_account_number}"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}


# Deploy ec2 in 1-st region

# Deploy ec2 in 2-nd region
data "aws_ami" "ubuntu-18_04-region2" {
  provider = aws.region2
  most_recent = true
  owners = ["${var.ubuntu_account_number}"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

# Outputs
output "ami-ubuntu-18_04-region1" {
    value = "${data.aws_ami.ubuntu-18_04-region1.id}"
}
output "ami-ubuntu-18_04-region2" {
    value = "${data.aws_ami.ubuntu-18_04-region2.id}"
}


# Provision & run tests

