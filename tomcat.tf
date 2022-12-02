#Create Security group for the private EC2 instance
resource "aws_security_group" "tomcat" {
  name   = "tomcat"
  description = "Allow SSH and TCP inbound traffic"
  vpc_id = aws_vpc.cgvpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${aws_security_group.bastion.id}"]
  }

  ingress {
    description = "TCP from alb"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = ["${aws_security_group.alb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
      tags = {
    Name = "${var.envname}-tomcat-sg"
  }
}


#Creating EC2 instance
resource "aws_instance" "tomcat" {
  ami = "ami-03f4fa076d2981b45"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.privatesubnet.id
  key_name = aws_key_pair.cg.id
  vpc_security_group_ids = ["${aws_security_group.tomcat.id}"]

  tags = {
    Name = "${var.envname}-tomcat"
  }
}
