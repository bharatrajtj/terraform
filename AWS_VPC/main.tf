provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "s3-remote-backend-2024"
    region = "us-east-2"
    key = "terraform/terraform.tfstate"
    dynamodb_table = "terraform-lock"
  }
}



module "VPC" {
    source = "./modules"
    public = "10.0.0.0/24"
    private = "10.0.1.0/24"
  
}

module "S3" {
    source = "./s3"
    AMI = "ami-0b8b44ec9a8f90422" 
    Instance = "t2.micro"
    subn = module.VPC.public_subnet
}
