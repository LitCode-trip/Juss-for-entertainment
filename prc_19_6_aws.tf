data "aws_security_group" "jankins" {
  name = "jankins"


}
resource "aws_instance" "janknx" {
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.jankins.id]
  ami                    = "ami-008a9f4478d7401d4"
  availability_zone      = "ap-south-1b"
  user_data              = <<-EOT
\#!/bin/bash
sudo apt-get update -y
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu noble stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y 
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

EOT

}

resource "aws_instance" "sql" {

  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.jankins.id]
  ami                    = "ami-008a9f4478d7401d4"
  availability_zone      = "ap-south-1b"
  user_data              = <<-EOT
#!/bin/bash
echo "hello Mf" >> /var/log/succ.log
EOT

}


resource "aws_instance_state" "stop_instance" {

  instance_id = "i-0ea59f2682c9904d2"
  state       = "stopped"


}



