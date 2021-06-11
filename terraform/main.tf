# creating aws instances

resource "aws_instance" "jenkins_machine" {
    ami = "ami-05f7491af5eef733a"
    instance_type = local.default_instance_type
    key_name = aws_key_pair.jenkins_key.key_name

    tags = {
      Name = "jenkins machine",
      distro = "Ubuntu"
    }

    vpc_security_group_ids = [aws_security_group.main.id]
}


resource "aws_instance" "test_machine" {
    count = local.test_machine_count
    ami = local.test_machine_ami
    instance_type = local.default_instance_type
    key_name = aws_key_pair.test_key.key_name

    tags = {
      Name = "test_${count.index + 1}",
      distro = local.test_machine_distro
    }

    vpc_security_group_ids = [aws_security_group.main.id]

}

resource "aws_instance" "stage_machine" {
    count = local.stage_machine_count
    ami = local.prod_machine_ami
    instance_type = local.default_instance_type
    key_name = aws_key_pair.stage_key.key_name

    tags = {
      Name = "stage_${count.index + 1}",
      distro = local.prod_machine_distro
    }

    vpc_security_group_ids = [aws_security_group.main.id]
}

resource "aws_instance" "prod_machine" {
    count = local.prod_machine_count
    ami = local.prod_machine_ami
    instance_type = local.default_instance_type
    key_name = aws_key_pair.prod_key.key_name

    tags = {
      Name = "prod_${count.index + 1}",
      distro = local.prod_machine_distro
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
