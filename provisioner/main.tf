provider "aws" {
    region = "us-east-2"

}

module "provisioner" {
    source = "./modules"  ###make sure the path is mentioned is modified according to the path folders are stored in your local machine
    CIDR = "10.0.0.0/16"
    PUBLIC_KEY = file("/home/ubuntu/terra.pub")
    SUBNETCIDR = "10.0.0.0/24"
    AMI = "ami-0b8b44ec9a8f90422"
    INSTANCE = "t2.micro"
    PRIVATEKEY = file("/home/ubuntu/terra")
}

output "ec2_output" {

    value = module.provisioner.PublicIP   ###This should be the block named defined in outputs.tf file

}
