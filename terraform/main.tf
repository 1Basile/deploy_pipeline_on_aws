# creating aws instances
resource "aws_instance" "ansible_machine" {
    ami = "ami-05f7491af5eef733a"
    instance_type = local.default_instance_type
    key_name = "ansible_key"

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
      key_name = "test_key"
    }
}

resource "aws_instance" "stage_machine" {
    ami = local.prod_machine_ami
    instance_type = local.default_instance_type

    tags = {
      Name = "Stage_1",
      distro = local.prod_machine_distro
      key_name = "stage_key"
    }
}

resource "aws_instance" "prod_machine" {
    ami = local.prod_machine_ami
    instance_type = local.default_instance_type

    tags = {
      Name = "Prod_1",
      distro = local.prod_machine_distro
      key_name = "prod_key"
    }
    vpc_security_group_ids = [aws_security_group.main.id]
}


resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}
