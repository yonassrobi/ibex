# <span style="color:#8B008B">IBEX</span> -  <span style="color:#8B008B">I</span>nfrastructure <span style="color:#8B008B">B</span>oilerplate <span style="color:#8B008B">EX</span>emplified

<img src="ibex.png" width="200">

## Overview
------------------
IBEX is a self proclaimed GOAT of modern infrastructure boilerplate that aims to drastically reduce the amount of time it takes to standup and maintain your infrastructure in AWS.

Under the hood IBEX uses carefully curated and fully customizable AWS Terraform modules and optional Packer templates to meet the typical infrastructure needs.

## Getting Started
------------------

1. Install Terraform
2. Optionally install Packer, if you would like to create custom AMIs
3. Clone this repository:
`
git clone [url] project-name
`
4. Configure your AWS credentials
5. Customize *./IBEX, ./terraform/live/global/&ast;.tfvars, ./terraform/live/env/&ast;.tfvars and ./terraform/live/main.tf* file with your infrastructure needs
6. Optionally update *./packer/<ami_type>/cookbooks/&ast;* with desired custom AMI updates
7. Unleash IBEX ... `./IBEX`

## Benefits
-----------
IBEX takes into consideration the following best practices:
* Keeps your terraform and state file configurations DRY
* Engrains High Availability and Disaster Recovery as a forethought
* Strongly encourages naming convention and tagging
* Auto-scaling and container ready


## Contribution
---------------
Contributions are always appreciated. Please submit a pull request.
