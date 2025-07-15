variable "aws-stg-env" {
  description = "detail to get aws stg instances"
  type = map(object({
    region        = string
    instance_type = string
    ami           = string
  }))
  default = {
    "stg-aps-1" = {
      region        = "ap-south-1"
      instance_type = "t2.micro"
      ami           = "ami-0b493594d6df1b528"
    }
    "stg-apse-1" = {
      region        = "ap-southeast-1"
      instance_type = "t2.micro"
      ami           = "ami-0ebe31c36caf13c6f"
    }
  }
}
variable "aws-prd-env" {
  description = "detail to get aws prd instances"
  type = map(object({
    region        = string
    instance_type = string
    ami           = string
  }))
  default = {
    "prd-aps-1" = {
      region        = "ap-south-1"
      instance_type = "t2.micro"
      ami           = "ami-0b493594d6df1b528"
    }
    "prd-apse-1" = {
      region        = "ap-southeast-1"
      instance_type = "t2.micro"
      ami           = "ami-0ebe31c36caf13c6f"
    }
  }
}
variable "sel_env" {
  description = "please enter the keys to select the environment"
  type        = string
}
