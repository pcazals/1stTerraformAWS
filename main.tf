variable "name" {
  type        = string
  description = "Name of the instance."
}

variable "instance_type" {
  type        = string
  description = "Instance types."
}

provider "aws" {}

module "ssh-module" {
  source              = "./ssh-module"
  name          = var.name
  instance_type = var.instance_type
}

output "public_dns" {
  value = module.ssh-module.public_dns
}

output "public_ip" {
  value = module.ssh-module.public_ip
}