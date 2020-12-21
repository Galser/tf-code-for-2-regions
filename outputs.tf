# Instance in region 1
output "instance_private_ip_region1" {
  value = module.compute_aws_region1.private_ip
}

output "instance_public_ip_region1" {
  value = module.compute_aws_region1.public_ip
}

# Instance in region 2
output "instance_private_ip_region2" {
  value = module.compute_aws_region2.private_ip
}

output "instance_public_ip_region2" {
  value = module.compute_aws_region2.public_ip
}


