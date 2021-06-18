locals {
    default_tags = {
      purpose = "Java pipeline project"
    }

    default_instance_type = "t2.micro"

    prod_machine_distro = "Ubuntu"
    prod_machines_user = "ubuntu"
    prod_machine_ami = "ami-05f7491af5eef733a"
    prod_machine_count = 1

    test_machine_distro = "Red Hat Enterprise Linux 8"
    test_machines_user = "ec2-user"
    test_machine_ami = "ami-06ec8443c2a35b0ba"
    test_machine_count = 1

    stage_machine_count = 1

    type_to_user = {
    "prod"  = "ubuntu"
    "test" =  "ec2-user"
    "stage" = "ubuntu"
  }
}
