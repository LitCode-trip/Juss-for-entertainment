variable "aws-prd-env" {
  description = "contrains production env material"
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
      ami               = "ami-06b0cffae0bd46b27"
      availability_zone = "ap-south-1b"
    }
    "prd-apse-1" = {
      region            = "ap-southeast-1"
      instance_type     = "t2.micro"
      ami               = "ami-06fb6b98af3176846"
      availability_zone = "ap-southeast-1b"
    }
  }
}
variable "aws-stg-env" {
  description = "contrains production stg material"
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
variable "prd-tags" {
  description = "adding prdutionn tags"
  type        = map(string)
  default = {
    env = "prd-nodes"
  }



}
variable "stg-tags" {
  description = "adding stagging tags"
  type        = map(string)
  default = {
    env = "stg_nodes"
  }



}
variable "sel_env" {
  description = "enter your env you want to create region  prd-aps-1 prd-apse-1 stg-aps-1 stg-apse-1"
  type        = string

}
