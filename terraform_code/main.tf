# VPC Creation
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "my_vpc"
  }
}

# Create Public Subnet

resource "aws_subnet" "my_pub_sub_01" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"
  tags = {
    Name = "my_pub_sub_1"
  }
}

resource "aws_subnet" "my_pub_sub_02" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1b"
  tags = {
    Name = "my_pub_sub_02"
  }
}

# Create IGW

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igw"
  }
}

# Create Route table

resource "aws_route_table" "my_pub_rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id 
  }
}

# Create Route Table for Subneet 1

resource "aws_route_table_association" "rta_pub_sub_01" {
    subnet_id = aws_subnet.my_pub_sub_01.id
    route_table_id = aws_route_table.my_pub_rt.id
}

# Create Route Table Association for Subnet 2

resource "aws_route_table_association" "rta_pub_sub_02" {
  subnet_id = aws_subnet.my_pub_sub_02.id
  route_table_id = aws_route_table.my_pub_rt.id
}

# AWS EC2 Instance creation
resource "aws_instance" "server-1" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id = aws_subnet.my_pub_sub_01.id
  for_each = toset(["Jenkins-master", "Build-slave", "Ansible"])
  tags = {
    Name = "${each.key}"
  }
}

# Creating Security Group for EC2 instance
resource "aws_security_group" "my_sg" {
    name        = "allow_tlsmy_sg"
    description = "Allow TLS inbound traffic"
    vpc_id = aws_vpc.my_vpc.id
  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
   ingress {
    description      = "Allow SSH"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "my_sg"
  }
}
