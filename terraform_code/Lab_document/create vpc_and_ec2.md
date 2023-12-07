# Terraform file to create VPC and EC2 
So far, we have created an EC2 instance with the Security group. Now let's create these in a separate VPC.
For that, we need to create VPC first. 

In VPC, there are various steps involved. 
1. Create VPC
2. Create a Subnet
3. Create Internet Gateway
4. Create RouteTable 
5. Route Table Association 

for_each in terraform
To create multiple EC2 instances in a single file we can use for_each

we can added below code snippet to the existing terraform file to create 3 instances as per our requirement.

for_each = toset(["master", "slave"])
   tags = {
     Name = "${each.key}"
   }

