provider "aws" {
  region = "us-east-2"
}





resource "aws_key_pair" "EC2KEYPAIR" {
  key_name = "ec2key"
  public_key = var.PUBLIC_KEY
}

resource "aws_vpc" "ProjectVPC" {
  cidr_block = var.CIDR
}

resource "aws_subnet" "ProjectPublicSubnet" {
  vpc_id = aws_vpc.ProjectVPC.id
  cidr_block = var.SUBNETCIDR
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.ProjectVPC.id
}


resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.ProjectVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id

  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.ProjectPublicSubnet.id
  route_table_id = aws_route_table.RT.id
  
}

resource "aws_security_group" "WebSG" {
  name = "web"
  vpc_id = aws_vpc.ProjectVPC.id
  
  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name ="web-sg"
  }
}


resource "aws_instance" "TerraformEC2" {

  ami = var.AMI
  instance_type = var.INSTANCE
  key_name = aws_key_pair.EC2KEYPAIR.key_name
  vpc_security_group_ids = [aws_security_group.WebSG.id]
  subnet_id = aws_subnet.ProjectPublicSubnet.id

  tags = {
    Name = "TerraformEc2"
  }

 connection {
    type = "ssh"
    user = "ubuntu"
    private_key = var.PRIVATEKEY
    host = self.public_ip
  }

 provisioner "file" {
  source = "app.py"
  destination = "/home/ubuntu/app.py"
  }

 provisioner "remote-exec" {
  inline = [ 
    "echo 'Hello Welcome to your EC2'",
    "sudo apt update -y",
    "sudo apt-get install -y python3-pip",
    "nohup sudo pip3 install flask &",
    "cd /home/ubuntu",
    "sudo python3 app.py",
   ]
  }
}
