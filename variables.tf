variable "region1" {
	default = "eu-west-1"
}

variable "region2" {
	default = "eu-west-3"
}


variable "region1_vpcCIDRblock" {
  default = "10.1.0.0/16"
}

variable "region1_subnetCIDRblock" {  
  default = "10.1.0.0/24"
}

variable "region2_vpcCIDRblock" {
   default = "172.16.0.0/16"
}

variable "region2_subnetCIDRblock" {
  default = "172.16.1.0/24" 
}

variable "ubuntu_account_number" {
  default = "099720109477"
}

variable "testname" {
  default = "agtest"
}

variable "tag" {
  default = "guselietov_test_2"
}

variable "instance_type" {
  default = "t2.micro"
}