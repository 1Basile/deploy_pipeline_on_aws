resource "tls_private_key" "ansible_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "test_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "prod_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "stage_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ansible_key" {
  key_name   = "ansible_key"
  public_key = tls_private_key.ansible_pk.public_key_pem

  # create private keys to be able to access with ansible
  provisioner "local-exec" {
      working_dir = "../access_keys"
      command = "echo ${tls_private_key.ansible_pk.private_key_pem} > ./ansible_key.pem && chmod 400 ansible_key.pem"
  }
}

resource "aws_key_pair" "prod_key" {
  key_name   = "prod_key"
  public_key = tls_private_key.prod_pk.public_key_openssh

  # create private keys to be able to access with ansible
  provisioner "local-exec" {
      command = "echo"
  }
}

resource "aws_key_pair" "test_key" {
  key_name   = "test_key"
  public_key = tls_private_key.test_pk.public_key_openssh

  # create private keys to be able to access with ansible
  provisioner "local-exec" {
      command = "echo"
  }
}

resource "aws_key_pair" "stage_key" {
  key_name   = "stage_key"
  public_key = tls_private_key.stage_pk.public_key_openssh

  # create private keys to be able to access with ansible
  provisioner "local-exec" {
      command = "echo"
  }
}
