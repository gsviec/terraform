### Manage AWS VPC as Infrastructure as Code with Terraform

This code creates AWS VPC resources, making a VPC in each of a regions and then two subnets in each VPC in three different availability zones.

To use it, firstly we need to install Terraform, find the [appropriate package](https://www.terraform.io/downloads.html) for your system and download it:

### Create AWS IAM User

Terraform uses AWS REST API to manage AWS resources, so we need to setup a new user account and I assume you have it

Copy to clipboard the Access Key ID and Secret Access Key, then set them as envrionment variables by running the commands below:

```
export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_ACCESS_KEY

```

Or put it into 

```
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
```