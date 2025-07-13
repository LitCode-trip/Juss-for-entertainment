variable "aws-prd-env" {
  description = "contain aws prod setting"
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
      ami               = "ami-0166e89d589bb1b2f"
      availability_zone = "ap-south-1b"
    }
    "prd-apse-1" = {
      region            = "ap-southeast-1"
      instance_type     = "t2.micro"
      ami               = "ami-08b138b7cf65145b1"
      availability_zone = "ap-southeast-1b"
    }
  }
}
variable "aws-stg-env" {
  description = "contain aws stg setting"
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
  description = "addiong tags for stagging area"
  type        = map(string)
  default = {
    Name = "Non-prod machine"
  }
}
variable "prd-tags" {
  description = "addiong tags for production area"
  type        = map(string)
  default = {
    Name = "Prod machine"
  }
}
variable "sel_env" {
  description = "env in both area are aws-stg-env contain [stg-aps-1 , stg-apse-1] and aws-prd-env contain [prd-aps-1 , prd-apse-1]"
  type        = string
}
