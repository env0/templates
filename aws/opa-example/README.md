# Open Policy Agent example
An example of enforcing policy-as-code running in env0

### Resources created
- Security group open for ingress on port 22

### Policy enforced 
- Validate that the CIDR block is not `0.0.0.0/0`. Any other valid CIDR block will pass the validation. 

### Variables
- Requires the AWS credentials in environment variables
- The `ssh_cidr_block` Terraform variable for the CIDR block (defauts to `0.0.0.0/0`). 

### Requirements
- Default VPC in the AWS Account
