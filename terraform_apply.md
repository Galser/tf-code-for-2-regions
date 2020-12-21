# Terraform `apply`

```Terraform
terraform apply --auto-approve
module.sshkey_aws_region1.aws_key_pair.sshkey: Creating...
module.vpc_aws_region1.aws_vpc.ag_test: Creating...
module.sshkey_aws_region2.aws_key_pair.sshkey: Creating...
module.vpc_aws_region2.aws_vpc.ag_test: Creating...
module.sshkey_aws_region1.aws_key_pair.sshkey: Creation complete after 0s [id=agtest-region1]
module.sshkey_aws_region2.aws_key_pair.sshkey: Creation complete after 0s [id=agtest-region2]
module.vpc_aws_region1.aws_vpc.ag_test: Creation complete after 2s [id=vpc-007501a32d761d69a]
module.vpc_aws_region1.aws_internet_gateway.ag_test: Creating...
module.vpc_aws_region1.aws_route_table.ag_test_route_table: Creating...
module.vpc_aws_region1.aws_subnet.ag_test: Creating...
module.vpc_aws_region1.aws_security_group.ag_test: Creating...
module.vpc_aws_region1.aws_route_table.ag_test_route_table: Creation complete after 1s [id=rtb-09a81b0bc348681b0]
module.vpc_aws_region1.aws_subnet.ag_test: Creation complete after 1s [id=subnet-0af5946c842bbe39f]
module.vpc_aws_region1.aws_route_table_association.ag_test_association: Creating...
module.vpc_aws_region2.aws_vpc.ag_test: Creation complete after 3s [id=vpc-069441bb092bd7855]
module.vpc_aws_region2.aws_internet_gateway.ag_test: Creating...
module.vpc_aws_region2.aws_route_table.ag_test_route_table: Creating...
module.vpc_aws_region2.aws_subnet.ag_test: Creating...
aws_vpc_peering_connection.peer: Creating...
module.vpc_aws_region2.aws_security_group.ag_test: Creating...
module.vpc_aws_region1.aws_internet_gateway.ag_test: Creation complete after 2s [id=igw-053a4c341a9fef409]
module.vpc_aws_region1.aws_route.ag_test_internet_access: Creating...
module.vpc_aws_region1.aws_route_table_association.ag_test_association: Creation complete after 1s [id=rtbassoc-0db1ca3de037c343c]
module.vpc_aws_region2.aws_route_table.ag_test_route_table: Creation complete after 1s [id=rtb-0028af543eff4fbf2]
module.vpc_aws_region1.aws_route.ag_test_internet_access: Creation complete after 0s [id=r-rtb-09a81b0bc348681b01080289494]
module.vpc_aws_region2.aws_subnet.ag_test: Creation complete after 1s [id=subnet-0cb7ca90abed64ca8]
module.vpc_aws_region2.aws_route_table_association.ag_test_association: Creating...
module.vpc_aws_region2.aws_internet_gateway.ag_test: Creation complete after 1s [id=igw-0213e36f5dd41fb3a]
module.vpc_aws_region2.aws_route.ag_test_internet_access: Creating...
module.vpc_aws_region2.aws_route_table_association.ag_test_association: Creation complete after 1s [id=rtbassoc-08ccab1d765d43578]
module.vpc_aws_region1.aws_security_group.ag_test: Creation complete after 3s [id=sg-0467a835a80b661a4]
module.compute_aws_region1.aws_instance.ec2: Creating...
module.vpc_aws_region2.aws_route.ag_test_internet_access: Creation complete after 1s [id=r-rtb-0028af543eff4fbf21080289494]
aws_vpc_peering_connection.peer: Creation complete after 2s [id=pcx-0901c427dee0a8f1b]
aws_vpc_peering_connection_accepter.peer: Creating...
aws_route.region1to2: Creating...
aws_route.region2to1: Creating...
module.vpc_aws_region2.aws_security_group.ag_test: Creation complete after 2s [id=sg-07c9650b6086fe574]
module.compute_aws_region2.aws_instance.ec2: Creating...
aws_route.region2to1: Creation complete after 1s [id=r-rtb-0028af543eff4fbf23322942084]
aws_route.region1to2: Creation complete after 1s [id=r-rtb-09a81b0bc348681b03246677288]
aws_vpc_peering_connection_accepter.peer: Creation complete after 3s [id=pcx-0901c427dee0a8f1b]
module.compute_aws_region1.aws_instance.ec2: Still creating... [10s elapsed]
module.compute_aws_region2.aws_instance.ec2: Still creating... [10s elapsed]
module.compute_aws_region1.aws_instance.ec2: Still creating... [20s elapsed]
module.compute_aws_region2.aws_instance.ec2: Still creating... [20s elapsed]
module.compute_aws_region2.aws_instance.ec2: Creation complete after 28s [id=i-0643250a19b2511e5]
module.compute_aws_region1.aws_instance.ec2: Still creating... [30s elapsed]
module.compute_aws_region1.aws_instance.ec2: Creation complete after 33s [id=i-08b30e278487fb636]
null_resource.test-region1: Creating...
null_resource.test-region2: Creating...
null_resource.test-region2: Provisioning with 'remote-exec'...
null_resource.test-region1: Provisioning with 'remote-exec'...
null_resource.test-region2 (remote-exec): Connecting to remote host via SSH...
null_resource.test-region2 (remote-exec):   Host: 15.237.74.215
null_resource.test-region2 (remote-exec):   User: ubuntu
null_resource.test-region2 (remote-exec):   Password: false
null_resource.test-region2 (remote-exec):   Private key: true
null_resource.test-region2 (remote-exec):   Certificate: false
null_resource.test-region2 (remote-exec):   SSH Agent: true
null_resource.test-region2 (remote-exec):   Checking Host Key: false
null_resource.test-region1 (remote-exec): Connecting to remote host via SSH...
null_resource.test-region1 (remote-exec):   Host: 52.210.83.59
null_resource.test-region1 (remote-exec):   User: ubuntu
null_resource.test-region1 (remote-exec):   Password: false
null_resource.test-region1 (remote-exec):   Private key: true
null_resource.test-region1 (remote-exec):   Certificate: false
null_resource.test-region1 (remote-exec):   SSH Agent: true
null_resource.test-region1 (remote-exec):   Checking Host Key: false
null_resource.test-region2 (remote-exec): Connecting to remote host via SSH...
null_resource.test-region2 (remote-exec):   Host: 15.237.74.215
null_resource.test-region2 (remote-exec):   User: ubuntu
null_resource.test-region2 (remote-exec):   Password: false
null_resource.test-region2 (remote-exec):   Private key: true
null_resource.test-region2 (remote-exec):   Certificate: false
null_resource.test-region2 (remote-exec):   SSH Agent: true
null_resource.test-region2 (remote-exec):   Checking Host Key: false
null_resource.test-region2 (remote-exec): Connecting to remote host via SSH...
null_resource.test-region2 (remote-exec):   Host: 15.237.74.215
null_resource.test-region2 (remote-exec):   User: ubuntu
null_resource.test-region2 (remote-exec):   Password: false
null_resource.test-region2 (remote-exec):   Private key: true
null_resource.test-region2 (remote-exec):   Certificate: false
null_resource.test-region2 (remote-exec):   SSH Agent: true
null_resource.test-region2 (remote-exec):   Checking Host Key: false
null_resource.test-region2 (remote-exec): Connecting to remote host via SSH...
null_resource.test-region2 (remote-exec):   Host: 15.237.74.215
null_resource.test-region2 (remote-exec):   User: ubuntu
null_resource.test-region2 (remote-exec):   Password: false
null_resource.test-region2 (remote-exec):   Private key: true
null_resource.test-region2 (remote-exec):   Certificate: false
null_resource.test-region2 (remote-exec):   SSH Agent: true
null_resource.test-region2 (remote-exec):   Checking Host Key: false
null_resource.test-region1 (remote-exec): Connecting to remote host via SSH...
null_resource.test-region1 (remote-exec):   Host: 52.210.83.59
null_resource.test-region1 (remote-exec):   User: ubuntu
null_resource.test-region1 (remote-exec):   Password: false
null_resource.test-region1 (remote-exec):   Private key: true
null_resource.test-region1 (remote-exec):   Certificate: false
null_resource.test-region1 (remote-exec):   SSH Agent: true
null_resource.test-region1 (remote-exec):   Checking Host Key: false
null_resource.test-region2: Still creating... [10s elapsed]
null_resource.test-region1: Still creating... [10s elapsed]
null_resource.test-region1 (remote-exec): Connecting to remote host via SSH...
null_resource.test-region1 (remote-exec):   Host: 52.210.83.59
null_resource.test-region1 (remote-exec):   User: ubuntu
null_resource.test-region1 (remote-exec):   Password: false
null_resource.test-region1 (remote-exec):   Private key: true
null_resource.test-region1 (remote-exec):   Certificate: false
null_resource.test-region1 (remote-exec):   SSH Agent: true
null_resource.test-region1 (remote-exec):   Checking Host Key: false
null_resource.test-region2 (remote-exec): Connected!
null_resource.test-region2 (remote-exec): Going to ping instance in 2-nd region via internal IP : [10.1.0.19]
null_resource.test-region2 (remote-exec): PING 10.1.0.19 (10.1.0.19) 56(84) bytes of data.
null_resource.test-region2 (remote-exec): 64 bytes from 10.1.0.19: icmp_seq=1 ttl=64 time=18.3 ms
null_resource.test-region2 (remote-exec): 64 bytes from 10.1.0.19: icmp_seq=2 ttl=64 time=17.7 ms
null_resource.test-region2 (remote-exec): 64 bytes from 10.1.0.19: icmp_seq=3 ttl=64 time=17.7 ms
null_resource.test-region2 (remote-exec): 64 bytes from 10.1.0.19: icmp_seq=4 ttl=64 time=17.7 ms

null_resource.test-region2 (remote-exec): --- 10.1.0.19 ping statistics ---
null_resource.test-region2 (remote-exec): 4 packets transmitted, 4 received, 0% packet loss, time 3006ms
null_resource.test-region2 (remote-exec): rtt min/avg/max/mdev = 17.704/17.888/18.340/0.278 ms
null_resource.test-region1 (remote-exec): Connecting to remote host via SSH...
null_resource.test-region1 (remote-exec):   Host: 52.210.83.59
null_resource.test-region1 (remote-exec):   User: ubuntu
null_resource.test-region1 (remote-exec):   Password: false
null_resource.test-region1 (remote-exec):   Private key: true
null_resource.test-region1 (remote-exec):   Certificate: false
null_resource.test-region1 (remote-exec):   SSH Agent: true
null_resource.test-region1 (remote-exec):   Checking Host Key: false
null_resource.test-region2: Creation complete after 14s [id=2821837441945621302]
null_resource.test-region1 (remote-exec): Connected!
null_resource.test-region1 (remote-exec): Going to ping instance in 2-nd region via internal IP : [172.16.1.195]
null_resource.test-region1 (remote-exec): PING 172.16.1.195 (172.16.1.195) 56(84) bytes of data.
null_resource.test-region1 (remote-exec): 64 bytes from 172.16.1.195: icmp_seq=1 ttl=64 time=18.1 ms
null_resource.test-region1 (remote-exec): 64 bytes from 172.16.1.195: icmp_seq=2 ttl=64 time=19.9 ms
null_resource.test-region1 (remote-exec): 64 bytes from 172.16.1.195: icmp_seq=3 ttl=64 time=17.9 ms
null_resource.test-region1 (remote-exec): 64 bytes from 172.16.1.195: icmp_seq=4 ttl=64 time=17.9 ms

null_resource.test-region1 (remote-exec): --- 172.16.1.195 ping statistics ---
null_resource.test-region1 (remote-exec): 4 packets transmitted, 4 received, 0% packet loss, time 3005ms
null_resource.test-region1 (remote-exec): rtt min/avg/max/mdev = 17.921/18.474/19.932/0.850 ms
null_resource.test-region1: Still creating... [20s elapsed]
null_resource.test-region1: Creation complete after 20s [id=9110557785537736423]

Apply complete! Resources: 24 added, 0 changed, 0 destroyed.

Outputs:

instance_private_ip_region1 = "10.1.0.19"
instance_private_ip_region2 = "172.16.1.195"
instance_public_ip_region1 = "52.210.83.59"
instance_public_ip_region2 = "15.237.74.215"
```