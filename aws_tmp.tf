provider "aws" {

    region = "ap-south-1"
    access_keys = "...."
    secreat_keys = "...."
}
data "aws_security_group" "jankins" {
    name = "jankins"

}

resource "aws_instace" "zdcsd(name)" {

    instace_type = "t2.micro"
    ami = "asdasdsaf"

    vpc_security_group_ids = [data.aws_security_group.jankins.id]


}

