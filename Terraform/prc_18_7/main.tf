locals {
  is_prd   = can(var.aws-prd-env[var.sel_env])
  get_env  = local.is_prd ? var.aws-prd-env : var.aws-stg-env
  set_env  = local.get_env[var.sel_env]
  set_tags = local.is_prd ? var.prd-tags : var.stg-tags
  merge_tags = merge(local.set_tags,
    {
      "Manages_By" : "Terraform"
    }
  )
}
data "aws_security_group" "jankins" {
  name = "jankins"
}
resource "aws_key_pair" "deployer" {
  key_name   = "tetrx"
  public_key = "ssh-rsa keyyyycx"

}
resource "aws_instance" "jenx" {
  instance_type          = local.set_env.instance_type
  ami                    = local.set_env.ami
  vpc_security_group_ids = [data.aws_security_group.jankins.id]
  availability_zone      = local.set_env.availability_zone
  tags                   = local.merge_tags
  key_name               = "tetrx"
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./tetrx")
    timeout     = "10m"
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "./docker_setup.sh"
    destination = "/home/ubuntu/docker_setup.sh"
  }
  provisioner "file" {
    source      = "./docker-compose.yml"
    destination = "/home/ubuntu/docker-compose.yml"
  }
  provisioner "file" {
    source      = "./getlogs.sh"
    destination = "/home/ubuntu/getlogs.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ubuntu/docker_setup.sh",
      "sudo apt-get update",
      "sudo bash /home/ubuntu/docker_setup.sh && sudo docker compose -f /home/ubuntu/docker-compose.yml up -d",
      "sleep 100",
      "sudo chmod +x /home/ubuntu/getlogs.sh",
      "sudo bash /home/ubuntu/getlogs.sh"

    ]
  }
}
output "instance_detail" {
  value = {
    public_ip = aws_instance.jenx.public_ip
  }
}
provider "aws" {
    region = local.set_env.region
}
