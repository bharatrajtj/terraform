In order to keep the Terraform State file secured and updated, we configure AWS S3 to be remote backend for terraform.
When more than one user concurrently give different configurations to terraform, a conflict occurs.
In order to overcome this conflict we use DynamoDB as a lock for terraform, that is if a user executes terraform apply then no other user can execute thir configuration until this configuration is built. This solves the conflict.
Make sure to create S3 and dynamoDB resource first before configuring the backend file.
