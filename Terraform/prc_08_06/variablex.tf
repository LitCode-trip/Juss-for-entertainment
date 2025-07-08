variable "aws-prd-env" {
  description = "things to set up the prod env in aws"
  type = map(object({
    instance_type     = string
    ami               = string
    availability_zone = string
    region            = string
  }))
  default = {
    "prd_aps_1" = {
      instance_type     = "t2.micro"
      ami               = "ami-0b493594d6df1b528"
      availability_zone = "ap-south-1b"
      region            = "ap-south-1"
    }
    "prd_apse-1" = {
      instance_type     = "t2.micro"
      ami               = "ami-08b138b7cf65145b1"
      availability_zone = "ap-southeast-1b"
      region            = "ap-southeast-1"
    }
  }
}
variable "aws-stg-env" {
  description = "things to set up stagginf env instance"
  type = map(object({
    instance_type     = string
    ami               = string
    availability_zone = string
    region            = string
  }))
  default = {
    stg_aps_1 = {
      instance_type     = "t2.micro"
      ami               = "ami-08b138b7cf65145b1"
      availability_zone = "ap-south-1a"
      region            = "ap-south-1"
    }
    stg_apse_1 = {
      instance_type     = "t2.micro"
      ami               = "ami-0b493594d6df1b528"
      availability_zone = "ap-southeast-1a"
      region            = "ap-southeast-1"
    }
  }
}
variable "prod_tags" {
  type        = map(string)
  description = "this is tags for prod env"
  default     = {
    "env" = "aws_prod" 
    "Managed-By" = "Terraform"
  }
}

variable "stg_tags" {
  type        = map(string)
  description = "tags for stagging env"
  default     = {
    "env" = "aws_stg" 
    "Managed-By" = "Terraform"
  }
}
variable "zone_info" {
  type    = list(string)
  default = ["prd_aps_1", "prd_apse_1", "stg_aps_1", "stg_apse_1"]
}
variable "sel_env" {
  type        = string
  description = "enter the zone"


}
