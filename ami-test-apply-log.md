## AMI getter test, for 2 different account via Doormat-injected credentials


```Terraform
Terraform v0.14.2
Initializing plugins and modules...

Warning: Interpolation-only expressions are deprecated

  on main.tf line 21, in data "aws_ami" "ubuntu-18_04-region1":
  21:   owners = ["${var.ubuntu_account_number}"]

Terraform 0.11 and earlier required all non-constant expressions to be
provided via interpolation syntax, but this pattern is now deprecated. To
silence this warning, remove the "${ sequence from the start and the }"
sequence from the end of this expression, leaving just the inner expression.

Template interpolation syntax is still used to construct strings from
expressions when the template includes multiple interpolation sequences or a
mixture of literal strings and interpolations. This deprecation applies only
to templates that consist entirely of a single interpolation sequence.

(and 3 more similar warnings elsewhere)


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

ami-ubuntu-18_04-region1 = "ami-08a099fcfc36dff3f"
ami-ubuntu-18_04-region2 = "ami-0b013f780a3e3b940"
```
