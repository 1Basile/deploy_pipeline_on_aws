locals {
    default_tags = {
      purpose = "Java pipline project"
    }

    default_instance_type = "t2.micro"

    prod_machine_distro = "Ubuntu"
    prod_machine_ami = "ami-05f7491af5eef733a"

    test_machine_distro = "Amazon linux 2"
    test_machine_ami = "ami-043097594a7df80ec"
}
