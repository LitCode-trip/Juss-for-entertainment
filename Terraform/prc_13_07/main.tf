provider "aws" {
  region = local.set_env.region
}

locals {
  is_prod  = can(var.aws-prd-env[var.sel_env])
  get_env  = local.is_prod ? var.aws-prd-env : var.aws-stg-env
  set_env  = local.get_env[var.sel_env]
  set_tags = local.is_prod ? var.prd-tags : var.stg-tags
  merge_tags = merge(local.set_tags,
    {
      "Managed_By" : "Terraform"
    }
  )
}
data "aws_security_group" "jankins" {
  name = "jankins"
}
resource "aws_instance" "hitthespot" {
  #  region = local.set_env.region
  instance_type          = local.set_env.instance_type
  ami                    = local.set_env.ami
  availability_zone      = local.set_env.availability_zone
  vpc_security_group_ids = [data.aws_security_group.jankins.id]
  tags                   = local.merge_tags
  provisioner "file" {

    source = "./jenkins.sh"
    destination = "/home/ubuntu/jenkins.sh"

  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubutnu/jenkins.sh",
      "sudo bash /home/ubuntu/jenkins.sh"
    ]
  }
  connection {
    host = self.public_ip
    type = "ssh"
    user = "ubuntu"
    private_key = ("./terra-aws")
    timeout = "5m"
  }
}
resource "aws_key_pair" {
  key_name = "aws-terra"
  public_key = "aws_terra"


}

}
output "instance_detail" {
  value = {
    public_ip     = aws_instance.hitthespot.public_ip
    instance_type = aws_instance.hitthespot.instance_type
    region        = local.set_env.region
  }
}
/*
  provisioner "file" {
 
    source = "./jenkins.sh"
    destination = "/home/ubuntu/jenkins.sh"

  } 

  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubutnu/jenkins.sh",
      "sudo bash /home/ubuntu/jenkins.sh"    
    ]
  }
  connection {
    host = self.public_ip
    type = "ssh"
    user = "ubuntu"
    private_key = ("./terra-aws")
    timeout = "5m"
  }
resource "aws_key_pair" {
  key_name = "aws-terra"
  


}
*/
