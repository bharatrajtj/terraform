variable "CIDR" {
  description = "CIDR RANGE FOR THE VPC"
  default = "10.0.0.0/16"
}

variable "PUBLIC_KEY" {
  description = "Location where the public key is stored"
}

variable "SUBNETCIDR" {
  description = "Cidr range for the subnet"
}

variable "AMI" {

    description = "AMI for EC2"
  }


variable "INSTANCE" {
    description = "Instance type for EC2"
  }

variable "PRIVATEKEY" {
    description = "Instance type for EC2"
  }
