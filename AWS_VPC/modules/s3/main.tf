resource "aws_s3_bucket" "TFS3" {
    bucket = "terraform130424e52024000"
  
}


resource "aws_instance" "EC2" {
    ami = var.AMI
    instance_type = var.Instance
    subnet_id = var.subn
    tags = {
      Name = "New"
    }
  
}
