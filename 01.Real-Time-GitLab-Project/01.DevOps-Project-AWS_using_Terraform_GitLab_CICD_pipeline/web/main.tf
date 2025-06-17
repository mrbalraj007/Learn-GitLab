data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "MYLABKEY"
  subnet_id = var.subnet_id
  security_groups = [var.SG_ID]


  #vpc_security_group_ids = [aws_security_group.Jenkins-VM-SG.id]
  #user_data              = templatefile("${path.module}/SonarQube-script.sh", {})
  #user_data = file("${path.module}/Jenkins-Master-script.sh")
  #user_data              = templatefile("./SonarQube-script.sh", {})

  tags = {
    Name = "MasterSVR"
  }

  root_block_device {
    volume_size = 8
  }
}

