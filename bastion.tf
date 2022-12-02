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
  key_name   = "cg-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCSBC1Bt4cp5tK8KdNQyp0JAOZB6hJbZk+6XH2uJFA4t3RC2XYSrPOnyHyS7UTjmxI7NopfcKbaBJ3DTf+7NDDP7iKNviEOhx40Fu1yhBT+kkbDhMBJuqCcSJ03s7r8HHjJZ/fPGAxUjW4llT1RumbgyyZrRsHr4Gl4o1a1QtLtH4tUxiU08NJyVxiYe+J6tDyqdvTm6URU0WzAiHNvmalO6tzIN59bVYVBlm/pYiZPaZ619nI8R7t8qL98gTbjY/ncKYdjQYQKZkQ2t7zCrPpcN8bKzGU2YB4WcGSvRjya4BzQrz0897c9p39xzvE/uGDkQhUbNpQqEBr+wPtwmYLn
}

 #Creating EC2 instance
 resource "aws_instance" "bastion" {
  ami = "ami-03f4fa076d2981b45"
  instance_type = var.instance_type
  subnet_id = aws_subnet.pubsubnet.id
  key_name = aws_key_pair.cg.id
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]

  tags = {
    Name = "${var.envname}-bastion"
  }
}

 
