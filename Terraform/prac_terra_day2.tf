resource "aws_security_group" "Docklockjen" {

   name = "Docklockjen"
   description = "Creating Sg for jen n dock"
   ingress {
     description = "jenkins_port"
     from_port = "8080"
     to_port = "8080"
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
     ipv6_cidr_blocks = ["::/0"]  
   }
   ingress { 
     description = "opening ssh" 
     from_port = "22" 
     to_port = "22" 
     protocol = "tcp" 
     cidr_blocks = ["0.0.0.0/0"]
     ipv6_cidr_blocks = ["::/0"]
   }
   ingress {
     description = "jenkins_agent_port"
     from_port = "50000"
     to_port = "50000"
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
     ipv6_cidr_blocks = ["::/0"]
   }
   egress {
     description = "default open"
     from_port = "0"
     to_port = "0"
     protocol = "-1"
     cidr_blocks = ["0.0.0.0/0"]     
   }
}
resource "aws_key_pair" "deployer" {
    key_name = "aws_terra"
    public_key = "$pubkey"
}
resource "aws_instance" "Docklock" {
    instance_type = "t2.micro"
    ami = "ami-008a9f4478d7401d4"
    vpc_security_group_ids = [aws_security_group.Docklockjen.id]
    availability_zone = "ap-south-1b"
    key_name = "aws_terra"

    provisioner "file" {
        source = "./jenkins-setup.sh"
        destination = "/home/ubuntu/jenkins-setup.sh"

    }
    provisioner "remote-exec" {
        inline = [
          "chmod +x /home/ubuntu/jenkins-setup.sh",
          "sudo bash /home/ubuntu/jenkins-setup.sh"  
        ]

    }
    connection {
        host = self.public_ip
        type = "ssh"
        user = "ubuntu"
        private_key = file("./aws_terra")
        timeout = "5m"
    }
}
