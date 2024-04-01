provider "aws" {
  region = "us-east-2"
}


resource "aws_instance" "EC2" {
  ami = "##AMI-ID"
  instance_type = "##Instance-type"
}

resource "aws_dynamodb_table" "terraform-lock" {
  name = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
