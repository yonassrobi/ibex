Modules
============

Carefully curated AWS Terraform modules to help you keep your code DRY.

Project Tree
============

```ascii

├──ec2                # EC2 instance
|  ├── main.tf            # Main Terraform file
|  ├── variables.tf       # Input variables file
|  └── outputs.tf         # Output variables file
├──elb                # Elastic Load Balancer
|  ├── main.tf            # Main Terraform file
|  ├── variables.tf       # Input variables file
|  └── outputs.tf         # Output variables file
├──iam                # Instance IAM profile
|  ├── main.tf            # Main Terraform file
|  ├── variables.tf       # Input variables file
|  └── outputs.tf         # Output variables file
├──key-pair           # EC2 Key pair
|  ├── main.tf            # Main Terraform file
|  ├── variables.tf       # Input variables file
|  └── outputs.tf         # Output variables file
├──label              # Standard naming and tagging
|  ├── main.tf            # Main Terraform file
|  ├── variables.tf       # Input variables file
|  └── outputs.tf         # Output variables file
├──security-group     # Security group
|  ├── main.tf            # Main Terraform file
|  ├── variables.tf       # Input variables file
|  └── outputs.tf         # Output variables file
├──tier               # Tier modules with ELB, EC2(s) and SG(s)
|  ├── main.tf            # Main Terraform file
|  ├── variables.tf       # Input variables file
└──└── outputs.tf         # Output variables file
```
