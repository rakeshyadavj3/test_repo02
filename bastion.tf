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
#Key pair value for creating EC2
resource "aws_key_pair" "cg" {
  key_name   = "jen-pub"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWEC86FC/qc3hexC+F+jVAa9VC5wyKlnBJKMza2aUoqMEtEbbq0COEvKMFjlsGqYw7+Qm6TpyMyzm+YtyTeBStMdlgNENQiPBlJE75dmi95BKKB9xtsuUY7Qf1rGeoUkuY5JR1eC9mQWbz7Lhf+8J7t3FAcFYUnzqU0YR5kfHQrxCcXbbXo7Y8lzQQjQagj2x189J1BFBfhAP/XlJgdTvvvwwyAoF41zIFb0xCtnn0BRJ/GDuu+OdHGJBIAeKOFQxDMD+0GoZSRlXxI+ifYrWi6DefGQ7oedW4GzaR/EnLSnVZ+RIp6mUmPDkD/2LjQfQqvpR4I3Xi2LQHW45DFf1nPYtOpdSnn7PqpRI4WF7oie0XFr5XFlXJ6+ZXzUcu7HXYkoeR9wkIszTe4HUGOaKVU8Zm+kQYzdVy8P51pbMGnYmmEj/xWz0pwHu3NVXreaN3kzUQEgvI3mdFcesBSYuV9oHf1jADmPPfsBl62qNQd227yLchM1CUZeuiyxHdqoc= ubuntu@ip-172-31-4-152"
}

 #Creating EC2 instance
 resource "aws_instance" "bastionjenpub" {
  ami = "ami-062df10d14676e201"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pubsubnet.id
  key_name = aws_key_pair.cg.id
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]

  tags = {
    Name = "${var.envname}-bastionjenpub"
  }
}

 
