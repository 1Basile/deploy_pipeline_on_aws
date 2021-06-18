# creating aws instances

resource "aws_instance" "jenkins_machine" {
    ami = "ami-05f7491af5eef733a"
    instance_type = local.default_instance_type
    key_name = aws_key_pair.jenkins_key.key_name

    tags = {
      Name = "jenkins machine",
      type = "jenkins_master",
      jenkins_name = "jenkins_machine",
      distro = "Ubuntu",
      user = "ubuntu"
    }

    vpc_security_group_ids = [aws_security_group.ssh_access_sg.id, aws_security_group.jenkins_access_sg.id]
}


resource "aws_instance" "test_machine" {
    count = local.test_machine_count
    ami = local.test_machine_ami
    instance_type = local.default_instance_type
    key_name = aws_key_pair.test_key.key_name

    tags = {
      Name = "test_${count.index + 1}",
      type = "test",
      jenkins_name = "test_${count.index + 1}",
      distro = local.test_machine_distro
      user = "ec2-user",
    }

    vpc_security_group_ids = [aws_security_group.ssh_access_sg.id, aws_security_group.web_server_sg.id]
}

resource "aws_instance" "stage_machine" {
    count = local.stage_machine_count
    ami = local.prod_machine_ami
    instance_type = local.default_instance_type
    key_name = aws_key_pair.stage_key.key_name

    tags = {
      Name = "stage_${count.index + 1}",
      type = "stage",
      jenkins_name = "stage_${count.index + 1}",
      distro = local.prod_machine_distro,
      user = "ubuntu"
    }

    vpc_security_group_ids = [aws_security_group.ssh_access_sg.id, aws_security_group.web_server_sg.id]
}

resource "aws_instance" "prod_machine" {
    count = local.prod_machine_count
    ami = local.prod_machine_ami
    instance_type = local.default_instance_type
    key_name = aws_key_pair.prod_key.key_name

    tags = {
      Name = "prod_${count.index + 1}",
      type = "prod",
      jenkins_name = "prod_${count.index + 1}",
      distro = local.prod_machine_distro,
      user = "ubuntu"
    }

    vpc_security_group_ids = [aws_security_group.ssh_access_sg.id, aws_security_group.web_server_sg.id]
}
