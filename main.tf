terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

resource "aws_key_pair" "generated_key" {
  key_name   = "PaulC-ssh"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_instance" "web" {
  ami           = "ami-00575c0cbc20caf50"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.generated_key.key_name
  tags = {
    Name = "PaulC"
  }
}