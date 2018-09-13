Terraform with IBEX
===================

This terraform project serves as a reference for the usage of various modules from the terraform directory. For consistency and Disaster Recovery considerations, the code is broken out to different environments and AWS regions.

Usage
=====
Instead of running Terrafrom directly, IBEX provides a bash script (IBEX) to keep configurations DRY. The common usage is as follows:
```
../IBEX [<mode>] [<project>] [<action>] [<environment>] [<region>]
```
> [mode]: default to t for terraform.

> [project]: specifies project name. Default to live

> [action]: specifies the following terraform actions: init, plan, apply, plan an destroy

> [Environment]: specifies desired environments

> [Region]: specifies desired AWS region

**Note**: Default values for the attributes can easily be changed on the IBEX script.
