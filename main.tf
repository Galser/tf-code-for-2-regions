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
  provider    = aws.region1
  most_recent = true
  owners      = [var.ubuntu_account_number]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}


# Get the AMI in region 2
data "aws_ami" "ubuntu-18_04-region2" {
  provider    = aws.region2
  most_recent = true
  owners      = [var.ubuntu_account_number]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

## REGION 1

# SSH Key : region 1
module "sshkey_aws_region1" {
  source = "./modules/sshkey_aws"
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
  subnetCIDRblock = "10.1.0.0/24"

  tag = var.tag
}

# Instance : AWS EC2 , instance 1
/* module "compute_aws_region1" {
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
} */

## REGION 2

# SSH Key : region 2
module "sshkey_aws_region2" {
  source = "./modules/sshkey_aws"
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

  #vpcCIDRblock = "10.2.0.0/16"
  vpcCIDRblock = "172.16.0.0/16"
  subnetCIDRblock = "172.16.1.0/24"

  tag = var.tag
}

# Instance : AWS EC2 , instance 1
/* module "compute_aws_region2" {
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
*/


# Create peering
data "aws_caller_identity" "peer" {
  provider = aws.region1
}


# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  provider      = aws.region1
  vpc_id        = module.vpc_aws_region1.id
  peer_vpc_id   = module.vpc_aws_region2.id
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_region   = var.region2  # !!! in current version of AWS inter-region peering
                               # not gonna owrk unless you speciyfing region here
  auto_accept   = false

  tags = {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.region2
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}    

# Provision Test 1 