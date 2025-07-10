locals {
  is_prod  = can(var.aws-prod-env[var.sel_env])
  get_env  = local.is_prod ? var.aws-prod-env : var.aws-stg-env
  set_env  = local.get_env[var.sel_env]
  get_tags = local.is_prod ? var.prd-tags : var.stg-tags
  merge_tags = merge(local.get_tags,
    {
      "Managed-By" : "Terraform"
    }
  )
}
data "aws_security_group" "jankins" {

  name = "jankins"

}
resource "aws_instance" "jhenny" {
  region                 = local.set_env.region
  instance_type          = local.set_env.instance_type
  ami                    = local.set_env.ami
  availability_zone      = local.set_env.availability_zone
  tags                   = local.merge_tags
  vpc_security_group_ids = [data.aws_security_group.jankins.id]
}
output "instance_details" {
  value = {
    instance_type = aws_instance.jhenny.instance_type
    region        = aws_instance.jhenny.region
    public_ip     = aws_instance.jhenny.public_ip
  }

}
provider "aws" {
  region = local.set_env.region



}
