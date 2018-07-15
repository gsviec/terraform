### Terraform-module-mongo

A terraform module for creating a mongo replica set that is kind of self healing. If an individual member dies, the auto scale group should relaunch it and it should rejoin automagically.

### Requirements

- Base ami (ubuntu, untested with anything else)
- Mongodb installed and configured
- EBS volume available at /dev/xvdg
- Name prefixed with `mongo-`

### Initial Setup

Just adding following command below and waiting a moment:

```
terraform init
terraform plan
terraform apply

```