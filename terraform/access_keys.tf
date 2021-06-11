resource "tls_private_key" "jenkins_pk" {
  algorithm = "RSA"
}

resource "tls_private_key" "test_pk" {
  algorithm = "RSA"
}

resource "tls_private_key" "prod_pk" {
  algorithm = "RSA"
}

resource "tls_private_key" "stage_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins_key"
  public_key = tls_private_key.jenkins_pk.public_key_openssh
}

resource "aws_key_pair" "prod_key" {
  key_name   = "prod_key"
  public_key = tls_private_key.prod_pk.public_key_openssh
}

resource "aws_key_pair" "test_key" {
  key_name   = "test_key"
  public_key = tls_private_key.test_pk.public_key_openssh
}

resource "aws_key_pair" "stage_key" {
  key_name   = "stage_key"
  public_key = tls_private_key.stage_pk.public_key_openssh
}


# create private keys

resource "local_file" "jenkins_key_file" {
  filename = pathexpand("../access_keys/jenkins_key.pem")
  file_permission = "400"
  directory_permission = "700"
  sensitive_content = tls_private_key.jenkins_pk.private_key_pem
}

resource "local_file" "prod_key_file" {
  filename = pathexpand("../access_keys/prod_key.pem")
  file_permission = "400"
  directory_permission = "700"
  sensitive_content = tls_private_key.prod_pk.private_key_pem
}

resource "local_file" "test_key_file" {
  filename = pathexpand("../access_keys/test_key.pem")
  file_permission = "400"
  directory_permission = "700"
  sensitive_content = tls_private_key.test_pk.private_key_pem
}

resource "local_file" "stage_key_file" {
  filename = pathexpand("../access_keys/stage_key.pem")
  file_permission = "400"
  directory_permission = "700"
  sensitive_content = tls_private_key.stage_pk.private_key_pem
}
