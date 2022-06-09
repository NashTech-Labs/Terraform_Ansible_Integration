provider "aws" {
  region = "us-east-1"

  access_key = var.AccessKey
  secret_key = avr.secret_key
}

locals {
  ssh_user         = "ubuntu"  #user as per your system
  key_name         = "tfkey"  #key 
  private_key_path = "~/Downloads/tfkey.pem"  #private key location

}

# Create a Ec2

resource "aws_instance" "ansible" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ansible.name]
  key_name                    = "tfkey"

  tags = {
    Name = "ansible"
  }

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(local.private_key_path)
      host        = aws_instance.ansible.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook -u ubuntu -i ${aws_instance.ansible.public_ip}, --private-key ${local.private_key_path} file.yaml"
  }
}

output "ansible" {
  value = aws_instance.ansible.public_ip
}





#create security group

resource "aws_security_group" "ansible" {
  name   = "ansible"
  vpc_id = "vpc-025bb59a9106d100a"

  # ingress {
  #   description = "HTTPS"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  # }

  # ingress {
  #   description = "HTTP"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Ansible_SG"
  }
}