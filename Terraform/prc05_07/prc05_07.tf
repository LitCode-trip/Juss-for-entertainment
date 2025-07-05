provider "aws" {
  region = var.prod_aws_ap_south_1.region
  access_key = var.prod_aws_ap_south_1.access_key
  secret_key = var.prod_aws_ap_south_1.secret_key


}
data "aws_security_group" "jankins" {
  name = "jankins"


}
resource "aws_instance" "jan" {
   instance_type = var.prod_aws_ap_south_1.instance_type
   vpc_security_group_ids = [data.aws_security_group.jankins.id]
   ami = var.prod_aws_ap_south_1.ami
   availability_zone = var.prod_aws_ap_south_1.availability_zone
   tags = var.tags_prod
}
