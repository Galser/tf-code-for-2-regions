# We dfein out 2 AWS provider aliases
# to emphasize different regions 
provider "aws" {
  alias  = "region1"
  region = var.region1
}

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
  key_path = var.ssh_key_path
}

# Network : AWS VPC , region 1
module "vpc_aws_region1" {
  source = "./modules/vpc_aws"
  providers = {
    aws = aws.region1
  }

  vpcCIDRblock = var.region1_vpcCIDRblock
  subnetCIDRblock = var.region1_subnetCIDRblock

  tag = var.tag
}

# Instance : AWS EC2 , instance in region 1
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
  key_path        = var.ssh_key_path
}

## REGION 2

# SSH Key : region 2
module "sshkey_aws_region2" {
  source = "./modules/sshkey_aws"
  providers = {
    aws = aws.region2
  }
  name     = "${var.testname}-region2"
  key_path = var.ssh_key_path
}

# Network : AWS VPC , region 2
module "vpc_aws_region2" {
  source = "./modules/vpc_aws"
  providers = {
    aws = aws.region2
  }

  vpcCIDRblock = var.region2_vpcCIDRblock
  subnetCIDRblock = var.region2_subnetCIDRblock

  tag = var.tag
}

# Instance : AWS EC2 , instance in region 2
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
  key_path        = var.ssh_key_path
}


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
                               # not gonna work unless you speciyfing region here
  auto_accept   = false        # This cannot be `true` when we specifying region above
                               # otherwise - fail 

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

# Explictly adding peering routes 
resource "aws_route" "region1to2" {
  provider                  = aws.region1
  route_table_id            = module.vpc_aws_region1.route_table_id
  destination_cidr_block    = var.region2_vpcCIDRblock
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "region2to1" {
  provider                  = aws.region2  
  route_table_id            = module.vpc_aws_region2.route_table_id
  destination_cidr_block    = var.region1_vpcCIDRblock
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Run tests

# instance 1 
resource "null_resource" "test-region1" {
  triggers = {
    instances_ids = join(",",[ 
      module.compute_aws_region1.instance_id,
      module.compute_aws_region2.instance_id
    ])
  }

  # explicit depends on routes and instances
  # as we need for BOTH to be up and ready
  # yet they can be deploy in parrallel by Terraform 
  depends_on = [
    aws_route.region1to2,
    aws_route.region2to1,
    module.compute_aws_region1,
    module.compute_aws_region2
  ]

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = file("~/.ssh/id_rsa")
    host        = module.compute_aws_region1.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo Going to ping instance in 2-nd region via internal IP : [${module.compute_aws_region2.private_ip}]",
      "echo My own internal ip is : [ ${module.compute_aws_region1.private_ip} ]",
      "ping -c 4 ${module.compute_aws_region2.private_ip}",
    ]
  }

}

# instance 2
resource "null_resource" "test-region2" {
  triggers = {
    instances_ids = join(",",[ 
      module.compute_aws_region1.instance_id,
      module.compute_aws_region2.instance_id
    ])
  }

  # explicit depends on routes and instances
  # as we need for BOTH to be up and ready
  # yet they can be deploy in parrallel by Terraform 
  depends_on = [
    aws_route.region1to2,
    aws_route.region2to1,
    module.compute_aws_region1,
    module.compute_aws_region2
  ]

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = file("~/.ssh/id_rsa")
    host        = module.compute_aws_region2.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo Going to ping instance in 1-st region via internal IP : [${module.compute_aws_region1.private_ip}]",
      "echo My own internal ip is : [ ${module.compute_aws_region2.private_ip} ]",
      "ping -c 4 ${module.compute_aws_region1.private_ip}",
    ]
  }

}
