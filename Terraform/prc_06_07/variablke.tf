variable "aws_pr_key" {
  description = "region for prod env"
  type = list
  default = ["ap-south-1" , "ap-southeast-2"]
}
variable "aws_prsec" {
  type = list
  description = "existing SG"
  default = ["sg-06bc495143cda05bc"]
}
variable "aws_prd_env" {
  type = map(object({
    instance_type = string
    ami = string
    region = string
  }))
  default = {
    "prod-aps-1" = {
    instance_type = "t2.micro"
    ami = "ami-06cc5ebfb8571a147"
    region = "ap-south-1"
    }
    "prod-apse-2" = {
      instance_type = "t2.micro"
      ami = "ami-04f7f2bb9a853a395"
      region = "ap-southeast-2"
    }
  }
}
variable "stg_tags" {
  type = map(object({
    env = string
  }))
  default = {
    "prd" = {
      env = "prod"
    }
    "stg" = {
      env = "stg"
    }
  }
}
variable "aws_stg_env" {
  type = map(object({
    instance_type = string
    ami = string
    region = string
  }))
  default = {
    "stg-aps-1" = {
    instance_type = "t2.micro"
    ami = "ami-06cc5ebfb8571a147"
    region = "ap-south-1"
    }
    "stg-apse-2" = {
      instance_type = "t2.micro"
      ami = "ami-04f7f2bb9a853a395"
      region = "ap-southeast-2"
    }
  }
}

variable "selected_environment_key" {
  description = "The key for the desired environment configuration (e.g., 'prod-aps-1', 'stg-apse-2')."
  type        = string
  # No default here, forcing you to specify it when running Terraform,
  # ensuring explicit environment selection.
}
