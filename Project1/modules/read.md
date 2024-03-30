The modules folder comprise of main.tf, outputs.tf, variables.tf files.
These files together when terraform init and terraform apply is executed will deploy EC2 instance in configured AWS account.
In real time project there will be lot of aws resources that will make it difficult to keep track of ownership, bug fix.
So, each resources are placed in a module folder.
We will then call this module using a different main.tf file that will all the files inside the module and create the resource.
