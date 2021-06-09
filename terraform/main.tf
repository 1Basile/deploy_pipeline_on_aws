provider "aws" {
    region = "eu-central-1"
    shared_credentials_file = "./tf_user/.aws/cred.csv"

    # setting default tags for all resource
    default_tags {
      tags = {
        purpose = "Java pipline project"
      }
    }
}

locals {
    default_instance_type = "t2.micro"

    prod_machine_distro = "Ubuntu"
    prod_machine_ami = "ami-05f7491af5eef733a"

    test_machine_distro = "Amazon linux 2"
    test_machine_ami = "ami-043097594a7df80ec"
}

# create instances
resource "aws_instance" "ansible_machine" {
    ami = "ami-05f7491af5eef733a"
    instance_type = local.default_instance_type

    tags = {
      Name = "Ansible machine",
      distro = "Ubuntu"
    }
}

resource "aws_instance" "test_machine" {
    ami = local.test_machine_ami
    instance_type = local.default_instance_type

    tags = {
      Name = "Test_1",
      distro = local.test_machine_distro
    }
}

resource "aws_instance" "stage_machine" {
    ami = local.prod_machine_ami
    instance_type = local.default_instance_type

    tags = {
      Name = "Stage_1",
      distro = local.prod_machine_distro
    }
}

resource "aws_instance" "prod_machine" {
    ami = local.prod_machine_ami
    instance_type = local.default_instance_type

    tags = {
      Name = "Prod_1",
      distro = local.prod_machine_distro
    }
}

# create vpc
resource "aws_vpc" "project-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Pipeline VPC",
  }
}

# creating subnet of every section

resource "aws_subnet" "prod_subnet" {
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = var.subnet_prefix[0].cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = var.subnet_prefix[0].name
  }
}

resource "aws_subnet" "stage_subnet" {
  vpc_id            = aws_vpc.prodject-vpc.id
  cidr_block        = var.subnet_prefix[0].cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = var.subnet_prefix[0].name
  }
}

resource "aws_subnet" "test_subnet" {
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = var.subnet_prefix[0].cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = var.subnet_prefix[0].name
  }
}
