locals {
  is_prod  = can(var.aws-prd-env[var.sel_env])
  get_env  = local.is_prod ? var.aws-prd-env : var.aws-stg-env
  set_env  = local.get_env[var.sel_env]
  get_tags = local.is_prod ? var.prd-tags : var.stg-tags
  merge_tags = merge(local.get_tags,
    {
      "Manages_by" : "Terraform"
    }
  )
}

provider "aws" {
  access_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  region = local.set_env.region
}
data "aws_security_group" "jankins" {
  name = "jankins"
}
resource "aws_instance" "jhen" {
  instance_type          = local.set_env.instance_type
  ami                    = local.set_env.ami
  availability_zone      = local.set_env.availability_zone
  vpc_security_group_ids = [data.aws_security_group.jankins.id]
}
output "instance_details" {
  value = {
    ami           = aws_instance.jhen.ami
    instance_type = aws_instance.jhen.instance_type
    publci-ip     = aws_instance.jhen.public_ip

  }


}
provisioner "remote-exec" {
  inline = [
    source = "."
    destination = ""

  ]
}
provisioner "file" {



}
resource "aws_key" {



}
