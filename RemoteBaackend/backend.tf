terraform {
  backend "s3" {
    bucket = "##S3bucketName"    ##Make sure to create a S3 bucket first.
     region = "us-east-2"
    key = "terraform/terraform.tfstate"
    dynamodb_table = "terraform-lock"
  }
}

