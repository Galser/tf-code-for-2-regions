# Destroy log

```Terraform
terraform destroy --auto-approve
module.vpc_aws_region2.aws_route_table_association.ag_test_association: Destroying... [id=rtbassoc-0034a0c630764525d]
module.vpc_aws_region2.aws_route.ag_test_internet_access: Destroying... [id=r-rtb-0afd62dfca75166e91080289494]
aws_vpc_peering_connection_accepter.peer: Destroying... [id=pcx-0850e2af94ebcb0a6]
aws_route.region2to1: Destroying... [id=r-rtb-0afd62dfca75166e93322942084]
aws_vpc_peering_connection_accepter.peer: Destruction complete after 0s
module.compute_aws_region2.aws_instance.ec2: Destroying... [id=i-0ebe13433a7a98940]
module.vpc_aws_region1.aws_route_table_association.ag_test_association: Destroying... [id=rtbassoc-05cf82c5e452f92bf]
module.vpc_aws_region1.aws_route.ag_test_internet_access: Destroying... [id=r-rtb-070357e5606035c381080289494]
aws_route.region1to2: Destroying... [id=r-rtb-070357e5606035c383246677288]
module.compute_aws_region1.aws_instance.ec2: Destroying... [id=i-089942f5ff428ed78]
aws_route.region2to1: Destruction complete after 0s
module.vpc_aws_region2.aws_route.ag_test_internet_access: Destruction complete after 0s
module.vpc_aws_region2.aws_route_table_association.ag_test_association: Destruction complete after 0s
module.vpc_aws_region2.aws_internet_gateway.ag_test: Destroying... [id=igw-05188cc5d550449a4]
module.vpc_aws_region2.aws_route_table.ag_test_route_table: Destroying... [id=rtb-0afd62dfca75166e9]
module.vpc_aws_region1.aws_route.ag_test_internet_access: Destruction complete after 0s
module.vpc_aws_region1.aws_internet_gateway.ag_test: Destroying... [id=igw-0c93396675d61e5fb]
aws_route.region1to2: Destruction complete after 0s
aws_vpc_peering_connection.peer: Destroying... [id=pcx-0850e2af94ebcb0a6]
module.vpc_aws_region1.aws_route_table_association.ag_test_association: Destruction complete after 0s
module.vpc_aws_region1.aws_route_table.ag_test_route_table: Destroying... [id=rtb-070357e5606035c38]
module.vpc_aws_region2.aws_route_table.ag_test_route_table: Destruction complete after 1s
module.vpc_aws_region1.aws_route_table.ag_test_route_table: Destruction complete after 1s
aws_vpc_peering_connection.peer: Destruction complete after 3s
module.compute_aws_region2.aws_instance.ec2: Still destroying... [id=i-0ebe13433a7a98940, 10s elapsed]
module.compute_aws_region1.aws_instance.ec2: Still destroying... [id=i-089942f5ff428ed78, 10s elapsed]
module.vpc_aws_region2.aws_internet_gateway.ag_test: Still destroying... [id=igw-05188cc5d550449a4, 10s elapsed]
module.vpc_aws_region1.aws_internet_gateway.ag_test: Still destroying... [id=igw-0c93396675d61e5fb, 10s elapsed]
module.compute_aws_region2.aws_instance.ec2: Still destroying... [id=i-0ebe13433a7a98940, 20s elapsed]
module.compute_aws_region1.aws_instance.ec2: Still destroying... [id=i-089942f5ff428ed78, 20s elapsed]
module.vpc_aws_region2.aws_internet_gateway.ag_test: Still destroying... [id=igw-05188cc5d550449a4, 20s elapsed]
module.vpc_aws_region1.aws_internet_gateway.ag_test: Still destroying... [id=igw-0c93396675d61e5fb, 20s elapsed]
module.vpc_aws_region2.aws_internet_gateway.ag_test: Destruction complete after 26s
module.vpc_aws_region1.aws_internet_gateway.ag_test: Destruction complete after 27s
module.compute_aws_region2.aws_instance.ec2: Still destroying... [id=i-0ebe13433a7a98940, 30s elapsed]
module.compute_aws_region2.aws_instance.ec2: Destruction complete after 30s
module.sshkey_aws_region2.aws_key_pair.sshkey: Destroying... [id=agtest-region2]
module.vpc_aws_region2.aws_subnet.ag_test: Destroying... [id=subnet-0c0f98c61b859fefd]
module.vpc_aws_region2.aws_security_group.ag_test: Destroying... [id=sg-011c030132b61a143]
module.compute_aws_region1.aws_instance.ec2: Still destroying... [id=i-089942f5ff428ed78, 30s elapsed]
module.sshkey_aws_region2.aws_key_pair.sshkey: Destruction complete after 0s
module.vpc_aws_region2.aws_security_group.ag_test: Destruction complete after 0s
module.compute_aws_region1.aws_instance.ec2: Destruction complete after 30s
module.sshkey_aws_region1.aws_key_pair.sshkey: Destroying... [id=agtest-region1]
module.vpc_aws_region1.aws_subnet.ag_test: Destroying... [id=subnet-0ed7a3f8aa22217fb]
module.vpc_aws_region1.aws_security_group.ag_test: Destroying... [id=sg-0e0ab11f5c12906f3]
module.vpc_aws_region2.aws_subnet.ag_test: Destruction complete after 0s
module.vpc_aws_region2.aws_vpc.ag_test: Destroying... [id=vpc-0646686b4dbda16ea]
module.sshkey_aws_region1.aws_key_pair.sshkey: Destruction complete after 1s
module.vpc_aws_region2.aws_vpc.ag_test: Destruction complete after 1s
module.vpc_aws_region1.aws_subnet.ag_test: Destruction complete after 1s
module.vpc_aws_region1.aws_security_group.ag_test: Destruction complete after 1s
module.vpc_aws_region1.aws_vpc.ag_test: Destroying... [id=vpc-0a94e6ee9d98a9219]
module.vpc_aws_region1.aws_vpc.ag_test: Destruction complete after 0s

Destroy complete! Resources: 22 destroyed.
```