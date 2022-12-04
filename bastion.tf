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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDastMrRfIRI/E6CmtCbdrd1sIJ3AoHqdat8MyA5tABd3vsZ7t4F4d0HbTaSaGOP8+I1Z0VV/92bl+pJJ//imXUdRKME2jQLwKJR3tjXAXzlwut47j+qUBYsaHQ8zT2LP2geYepDWw2zLjQI/j2Q2/onXyd+GmUDjUY+8q5+lHy96XlJI4FRQzNFLrwsQ3lbrWxfJxymEgkGL1tWGkhjYNJqp454xQXkSIciObcoX4nBxdkPPnBW3RlTfBMvLA9obXLz8iilF2qz4f8oZrytx8MZL6nNJDuw8rgy4VrvbXAUFzGgyaMk8RxjJJtEQ92YMvFmF001lZTMPaYByME7amxureqQNO9ypbuXAkAdZRJQkLtghxwk1COQydzLKuOk6YieXb/RSzJXpVlqSxGUiWcvW6OExZr210blzwE2BFvxkusRujlEYU+f/1YxoVj2E1hpq1OKoWTTyZ2A1W2UTyVlfPtEybhq3+aOqQCV9vF3nv/+036MbmcT1bv2UvZtf0= jenkins@ip-172-31-4-152"
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

 
