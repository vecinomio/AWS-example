# AWS-example
Deploying the simple application inside the Docker on the EC2 Instance of the Raised Terraform

- Terraform for creating instance
- Ansible for install tools and configuration
- Docker-compose for run containers
- Makefile for creating deb-package
 
Steps:
- be sure that the access key to EC2 is in the path: ~/.ssh/
- run terraform plan && terraform apply
- go to EC2 IP-address:8080 in the browser to check how it works
