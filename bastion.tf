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
  key_name   = "petclinic-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCs3svYc0xPZ5/VdcKUJIXtdtPTdT97qzlvAY3VRJbIy99MttxP3jMafQBu4jUfIdgsycavZ1r1/tiLyZEC9G5JQR+UpECDhgs82R1R+lJ1B5B4eI/JOKvjeUa07cJbsQf6MPwsjPrGNl9brunSYa5RUf/uGFZ9HB+A0tapAkAmaaK++eG8qwEVa5AOOtuMokUNNa4mp5MbgaGRyCmBUAjdPFPvapwVY2ZUkgWxtwAVaWfgFeoE4Mr5kEGaEM7QKBCyrWJXUdm94xUG/mF80XLdRSbIpCenXk5X0jBFwyGwBjkpOabhzNSNTEeALvxWAweKQV6ChivE60l/mRZLJl+03OEaUnxkCN4NzB38g1d+l/nJa8aQsfut8aUwFb3Af7JRHSpeU6q77Ot2YmMTJuJ70JzSXPYwr4Dl07AE1JSqr+1GonG8PEN/16YtqeomtD4Rmv4Vji38ppOA86l7bY68t3NKHfWXLV2/R31BmSZGlagwBkdoR40Enhd7vWrG+3c= Dell@DESKTOP-L2VAA49"
}

 #Creating EC2 instance
 resource "aws_instance" "bastion" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.pubsubnet.id
  key_name = aws_key_pair.cg.id
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]

  tags = {
    Name = "${var.envname}-bastion"
  }
}

 