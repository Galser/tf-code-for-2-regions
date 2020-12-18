# The default provider configuration; resources that begin with `aws_` will use
# it as the default, and it can be referenced as `aws`.
provider "aws" {
  alias  = "region1"
  region = var.region1
}

# Additional provider configuration for west coast region; resources can
# reference this as `aws.west`.
provider "aws" {
  alias  = "region2"
  region = var.region2
}

# Get the AMI in region 1
data "aws_ami" "ubuntu-18_04-region1" {
  provider = aws.region1
  most_recent = true
  owners = [var.ubuntu_account_number]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}


# Get the AMI in region 2
data "aws_ami" "ubuntu-18_04-region2" {
  provider = aws.region2
  most_recent = true
  owners = [var.ubuntu_account_number]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

## REGION 1

# SSH Key : region 1
module "sshkey_aws_region1" {
  source   = "./modules/sshkey_aws"
  providers = {
    aws = aws.region1
  }
  name     = "${var.testname}-region1"
  key_path = "~/.ssh/id_rsa.pub"
}

# Network : AWS VPC , region 1
module "vpc_aws_region1" {
  source = "./modules/vpc_aws"
  providers = {
    aws = aws.region1
  }

  vpcCIDRblock = "10.1.0.0/16"
  subnetCIDRblock = "10.1.1.0/24"

  tag              = var.tag
}

# Instance : AWS EC2 , instance 1
module "compute_aws_region1" {
  source = "./modules/compute_aws"
  providers = {
    aws = aws.region1
  }

  name            = "pinger1"
  ami             = data.aws_ami.ubuntu-18_04-region1.id
  instance_type   = var.instance_type
  security_groups = [module.vpc_aws_region1.security_group_id]
  subnet_id       = module.vpc_aws_region1.subnet_id
  key_name        = module.sshkey_aws_region1.key_id
  key_path        = "~/.ssh/id_rsa"
}

## REGION 2

# SSH Key : region 2
module "sshkey_aws_region2" {
  source   = "./modules/sshkey_aws"
  providers = {
    aws = aws.region2
  }
  name     = "${var.testname}-region2"
  key_path = "~/.ssh/id_rsa.pub"
}

# Network : AWS VPC , region 1
module "vpc_aws_region2" {
  source = "./modules/vpc_aws"
  providers = {
    aws = aws.region2
  }

  vpcCIDRblock = "10.1.0.0/16"
  subnetCIDRblock = "10.1.1.0/24"

  tag              = var.tag
}

# Instance : AWS EC2 , instance 1
module "compute_aws_region2" {
  source = "./modules/compute_aws"
  providers = {
    aws = aws.region2
  }

  name            = "pinger2"
  ami             = data.aws_ami.ubuntu-18_04-region2.id
  instance_type   = var.instance_type
  security_groups = [module.vpc_aws_region2.security_group_id]
  subnet_id       = module.vpc_aws_region2.subnet_id
  key_name        = module.sshkey_aws_region2.key_id
  key_path        = "~/.ssh/id_rsa"
}


# Provision Test 1 

# Peering
resource "aws_vpc_peering_connection" "test" {
  provider = aws.region1
  peer_vpc_id   = module.vpc_aws_region1.id
  vpc_id        = module.vpc_aws_region2.id
}


