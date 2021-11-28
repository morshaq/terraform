provider "aws" {
  region = "us-east-1"

}


resource "aws_security_group" "dokuwiki-sg" {
  name        = "dokuwiki-sg"
  description = "this is security group for dokuwiki"
  ingress {
    description      = "http port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dokuwiki_sg"
  }
}

resource "aws_instance" "moronen" {
  ami           = "ami-04ad2567c9e3d7893"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.dokuwiki-sg.id]
  tags = {
    Name = "dokuwiki_server"
  }
  /*
 user_data = <<EOF
#!/usr/bin/bash
yum install docker -y
systemctl enable docker
systemctl start docker
docker run -d -p 80:80 --name dokuwiki bitnami/dokuwiki:latest
EOF
*/
}

