resource "aws_security_group" "jankinsxx" {
    name = "jankinsxx"
 #    describe = "running jenkins as service on it"
    ingress {
      description = "enabling poer foir jenkins"
      from_port = "8080"
      to_port = "8080"
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    ingress {
      description = "enabling port for jenkins_agent"
      from_port = "50000"
      to_port = "50000"
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    ingress {
      description = "allowing ssh"
      from_port = "22"
      to_port = "22"
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "tcp"
    }
    egress {
      description = "allowing all egress"
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
}
resource "aws_instance" "Jankins" {
    instance_type = "t2.micro"
    ami = "ami-008a9f4478d7401d4"
    key_name = "aws_terra"
    vpc_security_group_ids = [aws_security_group.jankinsxx.id]
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ubuntu"
      private_key = file("./aws_terra")
      timeout = "5m"
    }
    provisioner "file" {

        source = "./setup-jenkins.sh"
        destination = "/home/ubuntu/setup-jenkins.sh"
    }
    provisioner "remote-exec" {
        inline = [
          "chmod +x /home/ubuntu/setup-jenkins.sh",
          "sudo bash /home/ubuntu/setup-jenkins.sh"
        ]
    }
}
resource "aws_key_pair" "deployer" {
    key_name = "aws_terra"
    public_key = "ssh-rsa $publickey"


}
