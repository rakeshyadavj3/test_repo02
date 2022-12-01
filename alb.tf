#Create Security group for the Bastion EC2 instance
resource "aws_security_group" "alb" {
  name   = "alb"
  description = "Allow alb inbound traffic"
  vpc_id = aws_vpc.cgvpc.id

  ingress {
    description = "alb from VPC"
    from_port   = 80
    to_port     = 80
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
    Name = "${var.envname}-alb-sg"
  }
}