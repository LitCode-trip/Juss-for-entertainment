locals {
  is_prod      = can(var.aws-prd-env[var.sel_env])
  get_env      = local.is_prod ? var.aws-prd-env : var.aws-stg-env
  set_config   = local.get_env[var.sel_env]
  get_env_tags = local.is_prod ? var.prod_tags : var.stg_tags
#  set_env_tags = local.get_env_tags[var.sel_env]
  merge_tags = merge(local.get_env_tags,
    {
       "name" = "${var.sel_env}-instance"
    }
  )
}
data "aws_security_group" "jankins" {
  name = "jankins"
}
resource "aws_instance" "jan" {
  instance_type          = local.set_config.instance_type
  ami                    = local.set_config.ami
  availability_zone      = local.set_config.availability_zone
  vpc_security_group_ids = [data.aws_security_group.jankins.id]
/*
merged_tags =  merge(local.get_env_tags,
    {  
      "name" = "${var.sel_env}-instance"
    }
  )
*/
  tags = local.merge_tags 
}
provider "aws" {
  region = local.set_config.region
}

output "instance_details" {
  description = "Details of the deployed EC2 instance."
  value = {
    id                 = aws_instance.jan.id
    type               = aws_instance.jan.instance_type
    ami                = aws_instance.jan.ami
    public_ip          = aws_instance.jan.public_ip
    availability_zone  = aws_instance.jan.availability_zone
    region             = local.set_config.region
    tags               = aws_instance.jan.tags
  }
}
