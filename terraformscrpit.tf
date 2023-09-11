terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAQNBZPI2DGO7FZJUD"
  secret_key = "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"
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create a subnet in the VPC
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_instance" "web" {
  count         = 2
  ami           = "ami-02bb7d8191b50f4bb"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id

  tags = {
    Name = "HelloWorld-${count.index}"
  }
}
