Live
====

Sample terraform project with a tier module or single instance.

Project Tree
============

```ascii

├── dev            # Environment directory
├── └──us-east-1   # AWS region
│      └── terraform.tfvars # Environment specific variables
├── test           # Environment directory
├── └──us-east-1   
│      └── terraform.tfvars
├── prod            # Environment directory
├── └──us-east-1   
│      └── terraform.tfvars
├── global          # Global variables shared across region
├── └──us-east-1    
│      └── terraform.tfvars # Global tfvars
├── IBEX           # Script for executing terraform commands
├── README.md      # This file
├── main.tf        # Main Terraform file
├── variables.tf   # Input variables file
└── outputs.tf     # Output variables file
```
