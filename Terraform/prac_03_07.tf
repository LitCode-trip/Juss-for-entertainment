provider "aws" {
  region = var.prod_aws_ap_south_1[0]
  access_key = var.prod_aws_ap_south_1[1]
  secreate_key = var.prod.aws_ap_south_1[2]  


}
data "aws_security_group" "jankins" {
  name = "jankins"


}
resource "aws_instance" "jan" {
   instance_type = var.prod_aws_ap_south_1[3]
   vpc_security_group_ids = [data.aws_security_key.id.jankins]
   ami = var.prod_aws_ap_south_1[4]
   availablity = var.prod_aws_ap_south_1[5]   
}
