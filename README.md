# tf-code-for-2-regions
Sample repo - code that creates resources in 2 regions and so they can ping each other via private IPs

# Requirements

This repository assumes general knowledge about Terraform and Terrafrom CLI v0.14.x , if not, please get yourself accustomed first by going through [getting started guide for Terraform](https://learn.hashicorp.com/terraform?track=getting-started#getting-started). We also going to use AWS EC2 as our infrastructure provider.

Please have TF v 0.14.X installed in advance.

To learn more about the mentioned above tools and technologies - please check section [Technologies near the end of the README](#technologies)

# How-to

## Prepare authentication credentials
- Beforehand, you will need to have SSH RSA key available at the default location :
 - `~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`
 > This key is going to be used later to connect to the instance where TFE will be running.
 
- Prepare AWS auth credentials (You can create security credentials on [this page](https://console.aws.amazon.com/iam/home?#security_credential).) To export them via env variables, execute in the command line :
 ```
 export AWS_ACCESS_KEY_ID="YOUR ACCESS KEY"
 export AWS_SECRET_ACCESS_KEY="YOUR SECRET KEY"
 ```

> If running in TFE/TFC you will need to define those variables in your workspace, or use some other method of AWS authorization

# 1. Create code

The general portion of the code is defined in [main.tf](main.tf)
It also utilizes modules from the subfolder `module` in the repository root.

The idea behind the test is that we are going : 

- To create 2 VPCs in each different region of AWS cloud and join them with peering to be able to ping each other using strictly only internal IP addresses
- In every VPC we need to create non-overlapping subnetworks (*that's the requirement of peering*)
- We need also to create a proper routing for our networks in every VPC, as VPC peering only does that - peering, and without adequate routes - EC2 instance will not know where to send packets, and they will go to the default GW
- And yes, we also need some default GW , in our case - to reach Internet (*so it's going to be IGW*) , or simply put for some manual tests via ssh over `public IP`.
- The very same public IP going to be used to execut automated 4-times ping of instances at the end after the full deploy,

All code is already implemented, what you may want to tweak is some region settings at the beginning of the file [variables.tf](variables.tf) : 

```Terrafrom
variable "region1" {
  default = "eu-west-1"
}

variable "region2" {
  default = "eu-west-3"
}
...
```

And, perhaps the path to your SSH key file at the very end of the same [variables.tf](variables.tf) : 

```Terraform
...
variable "ssh_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
```

## Notes on dependencies 

The tests themself - should be executed after both instances are up and we have routes in place and peering is up. And Terraform - either local CLI version or in the Terraform Cloud can execute deployment of infrastructure elements in parallel. That's why we have a test resource described like this : 

```Terrafrom
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
      "ping -c 4 ${module.compute_aws_region2.private_ip}",
    ]
  }

}
```

with explicit `depends_on` block. 


# 2. Deploy infrastructure and run test

- Init Terrafrom, execute `terrafrom init`
- Run apply : execute `terrafrom apply`
- Observe the tests near the end of the execution : 

```bash
...
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
...
```

As we can see there is `ping` command  from the instance in region 1 to the instance in region 2 : 

```
PING 10.1.0.19 (10.1.0.19) 56(84) bytes of data.
```
and it is successful : 

```
 4 packets transmitted, 4 received, 0% packet loss, time 3006ms
```

Same vice-versa. 

# Run logs

- terraform init : [terraform_init.md](terraform_init.md)
- terraform apply : [terraform_apply.md](terraform_apply.md)
- terraform destroy  : [terraform_destroy.md](terraform_destroy.md)

# Notes

1. Our Doormat having problems with EU-South region
2. Do not forget to open outgoing ICMP!!! Almost 1 hour lost

# Technologies

1. **To download the content of this repository** you will need **git command-line tools**(recommended) or **Git UI Client**. To install official command-line Git tools please [find here instructions](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) for various operating systems. 

2. **For managing infrastructure** we using Terraform - open-source infrastructure as a code software tool created by HashiCorp. It enables users to define and provision a data center infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON. More you encouraged to [learn here](https://www.terraform.io).
 
3. **This project for virtualization** uses **AWS EC2** - Amazon Elastic Compute Cloud (Amazon EC2 for short) - a web service that provides secure, resizable compute capacity in the cloud. It is designed to make web-scale cloud computing easier for developers. You can read in details and create a free try-out account if you don't have one here : [Amazon EC2 main page](https://aws.amazon.com/ec2/)

4. For connecting two regions seamlessly we are usign **VPC Peering**, more details can be found here : https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html


# TODO

- [x] - initial code
- [x] test doormat
- [x] add EC2 module
- [x] add tests
- [ ] README update
