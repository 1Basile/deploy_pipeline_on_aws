locals {
    default_tags = {
      purpose = "Java pipeline project"
    }

    default_instance_type = "t2.micro"

    prod_machine_distro = "Ubuntu"
    prod_machines_user = "ubuntu"
    prod_machine_ami = "ami-05f7491af5eef733a"
    prod_machine_count = 1

    test_machine_distro = "Amazon linux 2"
    test_machines_user = "ec2-user"
    test_machine_ami = "ami-043097594a7df80ec"
    test_machine_count = 2

    stage_machine_count = 1
}
