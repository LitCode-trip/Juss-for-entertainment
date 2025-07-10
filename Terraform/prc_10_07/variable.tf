variable "aws-prod-env" {
  description = "aws-prod-env"
  type = map(object({
    region            = string
    instance_type     = string
    ami               = string
    availability_zone = string
  }))
  default = {
    "prd-aps-1" = {
      region            = "ap-south-1"
      instance_type     = "t2.micro"
      ami               = "ami-047248cf574e28ecc"
      availability_zone = "ap-south-1b"
    }
    "prd-apse-1" = {
      region            = "ap-sotheast-1"
      instance_type     = "t2.micro"
      ami               = "ami-08b138b7cf65145b1"
      availability_zone = "ap-southeast-1b"
    }
  }
}
variable "aws-stg-env" {
  description = "aws-stg-env"
  type = map(object({
    region            = string
    instance_type     = string
    ami               = string
    availability_zone = string
  }))
  default = {
    "stg-aps-1" = {
      region            = "ap-south-1"
      instance_type     = "t2.micro"
      ami               = "ami-0b493594d6df1b528"
      availability_zone = "ap-south-1b"
    }
    "stg-apse-1" = {
      region            = "ap-southeast-1"
      instance_type     = "t2.micro"
      ami               = "ami-08a657649560db897"
      availability_zone = "ap-southeast-1b"

    }
  }
}
variable "stg-tags" {
  description = "stagging env tags"
  type        = map(string)
  default = {
    "env" = "stgging"

  }
}
variable "prd-tags" {
  description = "prod tags"
  type        = map(string)
  default = {
    "env" = "stagging"
  }
}
variable "sel_env" {
  type        = string
  description = "please select env available options are prd-aps-1 , prd-apse-1 , stg-apse-1 ,  stg-aps-1  "
}
