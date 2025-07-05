variable "prod_aws_ap_south_1" {
  type = object ({
  region = string
  access_key = string
  secret_key = string
  instance_type = string
  ami = string
  availability_zone = string
  })
  default = {
    region = "ap-south-1"
    access_key = "xxxxxxxxxxx"
    secret_key = "xxxxxxxxxxxxx"
    instance_type = "t2.micro"
    ami = "ami-008a9f4478d7401d4"
    availability_zone = "ap-south-1b"
  }
}

variable "tags_prod" {
  type = map
   default = {
     env = "prod"
     region = "ap-south-1b"
   }

}

