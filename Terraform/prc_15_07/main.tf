locals {
  is_prd  = can(var.aws-prd-env[var.sel_env])
  get_env = local.is_prd ? var.aws-prd-env : var.aws-stg-env
  set_env = local.get_env[var.sel_env]
}
data "aws_security_group" "jankins" {
  name = "jankins"
}

resource "aws_instance" "jan" {
  instance_type          = local.set_env.instance_type
  ami                    = local.set_env.ami
  vpc_security_group_ids = [data.aws_security_group.jankins.id]
  provisioner "file" {
    source = "./docker-setup.sh"
    destination = "/home/ubuntu/docker-setup.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/docker-setup.sh",
      "sudo bash /home/ubuntu/docker-setup.sh"
    ]
  }
/*
  provisioner "file" {
    source = "./docker-setup.sh"
    destination = "/home/ubuntu/docker-setup.sh" 

  }
*/
  key_name = "aws_trx"
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("./aws_trx")
    host = self.public_ip
    timeout = "5m"
  }
  
}
output "instance_detail" {
  value = {
    public_ip = aws_instance.jan.public_ip
  }
}
provider "aws" {
  region = local.set_env.region
}
 resource "aws_key_pair" "deployer" {
    key_name = "aws_trx"
    public_key = "demo ssh-rsa Asadsdfsdfkeyyyyy"
}
