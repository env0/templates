# Redash instance on AWS EC2
A Terraform 12 example of how to deploy an application onto an EC2 on AWS.  
In this example, we will deploy [Redash](https://redash.io/) 

![](sample.png)

## Configuration
- `AWS_ACCESS_KEY_ID` - Your AWS Secret Key ID  
- `AWS_SECRET_ACCESS_KEY` - You AWS Secret key. **Tick the "Secret" checkbox on env0 when setting this one**    

### Environment Variables
None  

### Terraform Variables
- `instance_type` - The [ec2 instance type](https://aws.amazon.com/ec2/instance-types/) (Defaults to `t2.small`)  

### Output
- `tls_private_key`: The private key to be used in order to ssh to the ec2 instance  
- `instance_public_ip`: The public IP of your Redash instance - Click on the URL on the Outputs tab of env0 to check it out!
