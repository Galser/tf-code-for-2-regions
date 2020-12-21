# Destroy log

```Terraform
terraform destroy --auto-approve
null_resource.test-region2: Destroying... [id=1970231708146190818]
null_resource.test-region1: Destroying... [id=2760740553218576761]
null_resource.test-region2: Destruction complete after 0s
null_resource.test-region1: Destruction complete after 0s
module.vpc_aws_region1.aws_route_table_association.ag_test_association: Destroying... [id=rtbassoc-0560b703f48a3e81a]
aws_route.region1to2: Destroying... [id=r-rtb-0e78fb59c763588623246677288]
module.vpc_aws_region1.aws_route.ag_test_internet_access: Destroying... [id=r-rtb-0e78fb59c763588621080289494]
module.compute_aws_region1.aws_instance.ec2: Destroying... [id=i-0627725512a48ac41]
module.vpc_aws_region2.aws_route_table_association.ag_test_association: Destroying... [id=rtbassoc-0269d1fd4d781644c]
aws_vpc_peering_connection_accepter.peer: Destroying... [id=pcx-01692f81e87ccb07b]
aws_route.region2to1: Destroying... [id=r-rtb-0349a5a2ec6f9ea153322942084]
module.vpc_aws_region2.aws_route.ag_test_internet_access: Destroying... [id=r-rtb-0349a5a2ec6f9ea151080289494]
aws_vpc_peering_connection_accepter.peer: Destruction complete after 0s
module.compute_aws_region2.aws_instance.ec2: Destroying... [id=i-00ce22d501c569d8d]
module.vpc_aws_region1.aws_route.ag_test_internet_access: Destruction complete after 0s
aws_route.region1to2: Destruction complete after 0s
module.vpc_aws_region1.aws_internet_gateway.ag_test: Destroying... [id=igw-076869166e721ae92]
module.vpc_aws_region1.aws_route_table_association.ag_test_association: Destruction complete after 0s
module.vpc_aws_region1.aws_route_table.ag_test_route_table: Destroying... [id=rtb-0e78fb59c76358862]
aws_route.region2to1: Destruction complete after 0s
module.vpc_aws_region2.aws_route.ag_test_internet_access: Destruction complete after 0s
module.vpc_aws_region2.aws_internet_gateway.ag_test: Destroying... [id=igw-02b6f19a300975a17]
aws_vpc_peering_connection.peer: Destroying... [id=pcx-01692f81e87ccb07b]
module.vpc_aws_region2.aws_route_table_association.ag_test_association: Destruction complete after 0s
module.vpc_aws_region2.aws_route_table.ag_test_route_table: Destroying... [id=rtb-0349a5a2ec6f9ea15]
module.vpc_aws_region2.aws_route_table.ag_test_route_table: Destruction complete after 1s
module.vpc_aws_region1.aws_route_table.ag_test_route_table: Destruction complete after 1s
aws_vpc_peering_connection.peer: Destruction complete after 2s
module.compute_aws_region1.aws_instance.ec2: Still destroying... [id=i-0627725512a48ac41, 10s elapsed]
module.compute_aws_region2.aws_instance.ec2: Still destroying... [id=i-00ce22d501c569d8d, 10s elapsed]
module.vpc_aws_region1.aws_internet_gateway.ag_test: Still destroying... [id=igw-076869166e721ae92, 10s elapsed]
module.vpc_aws_region2.aws_internet_gateway.ag_test: Still destroying... [id=igw-02b6f19a300975a17, 10s elapsed]
module.compute_aws_region1.aws_instance.ec2: Still destroying... [id=i-0627725512a48ac41, 20s elapsed]
module.compute_aws_region2.aws_instance.ec2: Still destroying... [id=i-00ce22d501c569d8d, 20s elapsed]
module.vpc_aws_region1.aws_internet_gateway.ag_test: Still destroying... [id=igw-076869166e721ae92, 20s elapsed]
module.vpc_aws_region2.aws_internet_gateway.ag_test: Still destroying... [id=igw-02b6f19a300975a17, 20s elapsed]
module.vpc_aws_region2.aws_internet_gateway.ag_test: Destruction complete after 26s
module.vpc_aws_region1.aws_internet_gateway.ag_test: Destruction complete after 26s
module.compute_aws_region1.aws_instance.ec2: Still destroying... [id=i-0627725512a48ac41, 30s elapsed]
module.compute_aws_region2.aws_instance.ec2: Still destroying... [id=i-00ce22d501c569d8d, 30s elapsed]
module.compute_aws_region2.aws_instance.ec2: Destruction complete after 30s
module.sshkey_aws_region2.aws_key_pair.sshkey: Destroying... [id=agtest-region2]
module.vpc_aws_region2.aws_subnet.ag_test: Destroying... [id=subnet-093332b4da7f89e13]
module.vpc_aws_region2.aws_security_group.ag_test: Destroying... [id=sg-0c3a95cb8c8df7e01]
module.compute_aws_region1.aws_instance.ec2: Destruction complete after 30s
module.sshkey_aws_region1.aws_key_pair.sshkey: Destroying... [id=agtest-region1]
module.vpc_aws_region1.aws_subnet.ag_test: Destroying... [id=subnet-051e1540c8998ee59]
module.vpc_aws_region1.aws_security_group.ag_test: Destroying... [id=sg-0c73c1e4666d430a3]
module.sshkey_aws_region2.aws_key_pair.sshkey: Destruction complete after 0s
module.sshkey_aws_region1.aws_key_pair.sshkey: Destruction complete after 0s
module.vpc_aws_region2.aws_security_group.ag_test: Destruction complete after 0s
module.vpc_aws_region2.aws_subnet.ag_test: Destruction complete after 1s
module.vpc_aws_region2.aws_vpc.ag_test: Destroying... [id=vpc-032bff313c438957d]
module.vpc_aws_region1.aws_subnet.ag_test: Destruction complete after 1s
module.vpc_aws_region1.aws_security_group.ag_test: Destruction complete after 1s
module.vpc_aws_region1.aws_vpc.ag_test: Destroying... [id=vpc-042b1bca7e2769c4d]
module.vpc_aws_region2.aws_vpc.ag_test: Destruction complete after 0s
module.vpc_aws_region1.aws_vpc.ag_test: Destruction complete after 0s

Destroy complete! Resources: 24 destroyed.
```