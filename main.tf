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

# Deploy ec2 in 1-st region

# Deploy ec2 in 2-nd region

# Provision & run tests

