<img src="https://www.knoldus.com/wp-content/uploads/Knoldus-logo-1.png" style="height: 90px">

# Run ansible-playbook using terraform ![Ansible](https://www.vectorlogo.zone/logos/ansible/ansible-ar21.svg)![Terraform](https://www.vectorlogo.zone/logos/terraformio/terraformio-icon.svg)

## Prerequisites 
* Terraform Install and updated.
* Ansible Installed. 
* ssh key should be created.
## Modify  [variable.tf](terraform/variable.tf)
```
variable "AccessKey" {
  default = ""

}
variable "region" {
  default = "us-east-1"
}
variable "ami" {
  default = "ami-09d56f8956ab235b3"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "secret_key" {
  default = ""
}
variable "vpc_id" {
  
  default = ""
}
```
Replace [file.yaml](terraform/file.yaml) with your role or playbook
## Command to run Terraform 
```
terraform validate
```
```
terraform init 
```
```
terraform apply
```