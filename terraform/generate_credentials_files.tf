# generate_ansible_hosts
resource "local_file" "hosts_cfg" {
  content = templatefile("templates/hosts.tmpl",
    {
      jenkins_machine = aws_instance.jenkins_machine

      test_machines = aws_instance.test_machine
      test_machines_user = local.test_machines_user

      stage_machines = aws_instance.stage_machine

#      prod_machines = aws_instance.prod_machine
      prod_machines_user = local.prod_machines_user

    }
  )
  filename = "../ansible/inventory/hosts.cfg"
}

resource "local_file" "jenkins_slave_cfg" {
  content = templatefile("templates/node_config.tmpl",
    {
      machines = flatten([aws_instance.test_machine, aws_instance.stage_machine])
    }
  )
  filename = "../ansible/roles/install-jenkins-master/files/all_nodes.xml"
}

resource "local_file" "jenkins_credentials_cfg" {
  content = templatefile("templates/jenkins_template_credentials.tmpl",
    {
      test_key_name = aws_key_pair.test_key.key_name
      #test_private_key = replace(trimsuffix(trimprefix(tls_private_key.test_pk.private_key_pem, "-----BEGIN RSA PRIVATE KEY-----\n"), "-----END RSA PRIVATE KEY-----\n"), "\n", "")
      test_private_key = tls_private_key.test_pk.private_key_pem
      test_user = local.test_machines_user
      stage_key_name = aws_key_pair.stage_key.key_name
      stage_private_key = replace(trimsuffix(trimprefix(tls_private_key.stage_pk.private_key_pem, "-----BEGIN RSA PRIVATE KEY-----\n"), "-----END RSA PRIVATE KEY-----\n"), "\n", "")
      prod_key_name = aws_key_pair.prod_key.key_name
      prod_private_key = replace(trimsuffix(trimprefix(tls_private_key.prod_pk.private_key_pem, "-----BEGIN RSA PRIVATE KEY-----\n"), "-----END RSA PRIVATE KEY-----\n"), "\n", "")
      prod_user = local.prod_machines_user
    }
  )
  filename = "../ansible/roles/install-jenkins-master/files/credentials.xml"
}

resource "local_file" "ssh_test_key_jenkins_cfg" {
  content = templatefile("templates/ssh_host_key_jenkins.tmpl",
    {
      key = aws_key_pair.test_key
    }
  )
  filename = "../ansible/roles/install-jenkins-master/files/test__ssh_host_key.xml"
}

resource "local_file" "ssh_prod_key_jenkins_cfg" {
  content = templatefile("templates/ssh_host_key_jenkins.tmpl",
    {
      key = aws_key_pair.prod_key
    }
  )
  filename = "../ansible/roles/install-jenkins-master/files/prod__ssh_host_key.xml"
}

resource "local_file" "ssh_stage_key_jenkins_cfg" {
  content = templatefile("templates/ssh_host_key_jenkins.tmpl",
    {
      key = aws_key_pair.stage_key
    }
  )
  filename = "../ansible/roles/install-jenkins-master/files/stage__ssh_host_key.xml"
}

resource "null_resource" "node_config_files_jenkins" {
    provisioner "local-exec" {
      command = "python scripts/create_node_config_files.py"
    }
    depends_on = [
      local_file.jenkins_slave_cfg,
    ]
}
