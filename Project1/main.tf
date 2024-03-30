provider "aws" {
    region = "us-east-2"
    access_key = "your_access_key"
    secret_key = "your_secret_key"
}

module "ec2" {
    source = "./modules"  ###make sure the path is mentioned is modified according to the path folders are stored in your local machine
    ami_value = "##Give AMI values"
    instance_type_value = "###Give EC2 instance type"
}

output "ec2_output" {

    value = module.ec2.PublicIP   ###This should be the block named defined in outputs.tf file  
  
}
