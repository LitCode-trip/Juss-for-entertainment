variable "aws-prd-env" {
  description = "this swill conmtain prd instacnes"
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
      ami               = "ami-06cc5ebfb8571a147"
      availability_zone = "ap-south-1b"
    }
    "prd-apse-1" = {
      region            = "ap-southeast-1"
      instance_type     = "t2.micro"
      ami               = "ami-0b874c2ac1b5e9957"
      availability_zone = "ap-southeast-1b"
    }
  }
}
variable "aws-stg-env" {
  description = "this will contain stagging instacnes"
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
      ami               = "ami-06cc5ebfb8571a147"
      availability_zone = "ap-south-1b"
    }
    "stg-apse-1" = {
      region            = "ap-southeast-1"
      instance_type     = "t2.micro"
      ami               = "ami-0b874c2ac1b5e9957"
      availability_zone = "ap-southeast-1b"
    }
  }
}
variable "prd-tags" {
  description = "this is production taggs"
  type        = map(string)
  default = {
    ENV = "production"
  }
}
variable "stg-tags" {
  description = "this is stagging taggs"
  type        = map(string)
  default = {
    ENV = "stagging"
  }
}
variable "sel_env" {
  description = "key for aws-prd-env are [prd-aps-1 , prd-apse-1] for aws-stg-env [stg-aps-1 , stg-apse-1] "
  type        = string
}
