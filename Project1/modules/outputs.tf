output "PublicIP" {
    value = aws_instance.EC2.public_ip    ####will print the newly created EC2 instance Public IP value in the terminal
  
}
