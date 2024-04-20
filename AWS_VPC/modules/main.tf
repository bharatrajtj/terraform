resource "aws_vpc" "TER" {
 cidr_block = "10.0.0.0/16"
 tags = {
   Name = "TerraformVPC"
 }
}   

resource "aws_subnet" "PUBLIC" {
    vpc_id = aws_vpc.TER.id
    cidr_block = var.public
    tags = {
      Name = "PUBLIC"
    } 
}

output "public_subnet" {
  value = aws_subnet.PUBLIC.id
}
resource "aws_subnet" "PRIVATE" {
  vpc_id = aws_vpc.TER.id
  cidr_block = var.private
  tags = {
    Name = "PRIVATE"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.TER.id
  tags = {
    Name = "InternetGateway"
  }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.TER.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
}

resource "aws_route_table_association" "RTA" {
  subnet_id = aws_subnet.PUBLIC.id
  route_table_id = aws_route_table.RT.id
}


resource "aws_eip" "EIP" {
  domain = "vpc"
}

resource "aws_nat_gateway" "NAT" {
   allocation_id = aws_eip.EIP.id
   subnet_id = aws_subnet.PRIVATE.id
}

resource "aws_route_table" "RT2" {
  vpc_id = aws_vpc.TER.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NAT.id
  }
}

resource "aws_route_table_association" "RTA1" {
  subnet_id = aws_subnet.PRIVATE.id
  route_table_id = aws_route_table.RT2.id
}


resource "aws_security_group" "SG" {
  name_prefix = "TFSG"
  vpc_id = aws_vpc.TER.id
  
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TFSG"
  }

}
