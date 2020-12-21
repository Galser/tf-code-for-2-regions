# Terrafomr `init`



```Terraform
terraform init
Initializing modules...
- compute_aws_region1 in modules/compute_aws
- compute_aws_region2 in modules/compute_aws
- sshkey_aws_region1 in modules/sshkey_aws
- sshkey_aws_region2 in modules/sshkey_aws
- vpc_aws_region1 in modules/vpc_aws
- vpc_aws_region2 in modules/vpc_aws

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/null...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/null v3.0.0...
- Installed hashicorp/null v3.0.0 (signed by HashiCorp)
- Installing hashicorp/aws v3.22.0...
- Installed hashicorp/aws v3.22.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```