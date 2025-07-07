variable "aws_prd_env" {
  type = map(object({
    instance_type     = string
    ami               = string
    availability_zone = string
    region = string
  }))
  default = {
    prd-aps-1 = {
      instance_type     = "t2.micro"
      ami               = "ami-06cc5ebfb8571a147"
      availability_zone = "ap-south-1b"
      region = "ap-south-1"
    }
    prd-apse-1 = {
      instance_type    = "t2.micro"
      ami              = "ami-08a657649560db897"
      availability_zone = "ap-southeast-1b"
      region = "ap-southeast-1"
    }
  }
}
variable "aws_stg_env" {
  type = map(object({
    instance_type    = string
    ami              = string
    availability_zone = string
    region = string
  }))
  default = {
    stg-aps-1 = {
      instance_type    = "t2.micro"
      ami              = "ami-0b493594d6df1b528"
      availability_zone = "ap-south-1b"
      region = "ap-south-1"
    }
    stg-apse-1 = {
      instance_type     = "t2.micro"
      ami               = "ami-08b138b7cf65145b1"
      availability_zone = "ap-southeast-1b"
      region = "ap-southeast-1"
    }
  }
}
variable "prd_tags" {
  type = map(object({
    env = string
  }))
  default = {
    prd-aps-1 = {
      env = "prodution_machine ap-south-1"
    }
    prd-apse-1 = {
      env = "production_machine in ap-southeast-1"
    }
  }
}
variable "stg_tags" {
  type = map(object({
    env = string
  }))
  default = {
    stg-aps-1 = {
      env = "prodution_machine ap-south-1"
    }
    stg-apse-1 = {
      env = "production_machine in ap-southeast-1"
    }
  }
}
variable "avaiable_env" {
  type        = list(string)
  description = "the region to launch the machine"
  default     = ["prd-aps-1", "prd-apse-1", "stg-aps-1", "stg-apse-1"]

}
variable "sel_env" {
  type        = string
  description = "sel env to launch the instance"
}
/*
variable "sel_tags_env" {
  type = string
  description = ""
}
*/
