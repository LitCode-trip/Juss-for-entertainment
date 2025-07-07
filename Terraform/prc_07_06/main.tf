locals {
  what_env          = can(var.aws_prd_env[var.sel_env])
  sel_env           = local.what_env ? var.aws_prd_env : var.aws_stg_env
  set_instance      = local.sel_env[var.sel_env]
  set_tags_env      = local.what_env ? var.prd_tags : var.stg_tags
  set_instance_tags = local.set_tags_env[var.sel_env]
  instance_tag = merge(
    local.set_instance_tags,
    {
      "name"       = "${var.sel_env}-instance"
      "Managed-by" = "terraform"
    }
  )
}
provider "aws" {
  region = local.set_instance.region
  access_key = "xxxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxx"  
}
data "aws_security_group" "jankins" {
  name = "jankins"
}
resource "aws_instance" "Jhenny" {
  instance_type          = local.set_instance.instance_type
  ami                    = local.set_instance.ami
  availability_zone      = local.set_instance.availability_zone
  vpc_security_group_ids = [data.aws_security_group.jankins.id]
  tags                   = local.set_instance_tags
}
/*
output "used_instance_detail" {

  value = [
    "Instance_type: ${aws_instance.jhenny.instance_type}",
    "AMI:  ${aws_instance.jhenny.ami}",
    "Instance_public_ip: ${aws_instance.jhenny.public_ip}",
    "IUnstance region: ${local.set_instance.region}",
    "Tags Applied: ${jsonencode(aws_instance.Jhenny.tags)}"
  ]
}
*/
