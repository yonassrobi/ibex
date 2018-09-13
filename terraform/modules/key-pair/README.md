AWS Key Pair Terraform Module
===========

---

A terraform module to create or import an AWS Key Pair


Module Input Variables
----------------------

- `key_directory` - name of the directory to save any generated keys in
- `import_key` - true/false.
- `key_name` - name of the key to be generated/imported

Usage
-----

Create a main.tf file as follows:

```hcl
module "key_pair" {
  source                  = "../modules/key-pair"
  key_directory           = "live"
  key_name                = "lvdv-app"
}
```
Then you can run terraform as usual

Key Storage
==================

All generated keys are stored in the `.ssh/terraform` directory, under
the specified sub directory (`key_directory`).

Outputs
=======

 - `key-name` - name of the AWS Key Pair created
