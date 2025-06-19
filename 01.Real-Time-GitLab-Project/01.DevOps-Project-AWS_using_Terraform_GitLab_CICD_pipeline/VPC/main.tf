# 1 VPC, 1 Subnet, 1 Security Group

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "myvpc"
  }
}

resource "aws_subnet" "pb_sn" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "pb_sn"
  }
}

resource "aws_security_group" "pb_sg" {
  name        = "my_pb_sg"
  description = "Allow inbound traffic to the public subnet"
  vpc_id      = aws_vpc.myvpc.id

 ingress = [
    for port in [22, 80, 443, 8080, 9000, 3000] : {
      description      = "inbound rules"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     security_groups  = []
    self             = false
    }
  ]
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}