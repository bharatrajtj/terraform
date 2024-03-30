provider "aws" {
  region = "us-east-2"
  access_key = "your_access_key"
  secret_key = "your_secret_key"
}


resource "aws_instance" "EC2" {
  ami = var.ami_value
  instance_type = var.instance_type_value
    tags =  {
    Name = "TerraformProject"
  }
}
