#Create Security group for the Bastion EC2 instance
resource "aws_security_group" "bastion" {
  name   = "bastion"
  description = "Allow SSH inbound traffic"
  vpc_id = aws_vpc.cgvpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
      Name = "${var.envname}-bastion-sg"
  }
}


 #Creating EC2 instance
 resource "aws_instance" "bastion" {
  ami = "ami-062df10d14676e201"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pubsubnet.id
  key_name = "sj"
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]

  tags = {
    Name = "${var.envname}-bastion"
  }
}

 
