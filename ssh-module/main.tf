terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_key_pair" "local_key" {
  key_name   = "Paul-sshKey"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "amazon2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-gp2"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name  = "architecture"
    values = ["x86_64"]
  }
}

data "aws_subnet" "subnet" {
  filter {
    name  = "subnet-id"
    values = ["subnet-0c3887716d524577a"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon2.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.subnet.id
  key_name      = aws_key_pair.local_key.key_name
  tags = {
    Name = var.name
  }
}

output "public_dns" {
  value = aws_instance.web.public_dns
}

output "public_ip" {
  value = aws_instance.web.public_ip
}