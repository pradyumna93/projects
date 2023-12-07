variable "region" {
  description = "This is the default region"
  default = "ap-south-1"
}

variable "ami" {
    default = "ami-0a7cf821b91bcccbc"
}

variable "key_name" {
  default = "aws_key"
}

variable "instance_type" {
  default = "t2.micro"
}