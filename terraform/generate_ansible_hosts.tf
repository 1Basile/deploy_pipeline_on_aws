resource "local_file" "hosts_cfg" {
  content = templatefile("templates/hosts.tmpl",
    {
      jenkins_machine = aws_instance.jenkins_machine

      test_machines = aws_instance.test_machine
      test_machines_user = local.test_machines_user

      stage_machines = aws_instance.stage_machine

      prod_machines = aws_instance.prod_machine
      prod_machines_user = local.prod_machines_user

    }
  )
  filename = "../ansible/inventory/hosts.cfg"
}
