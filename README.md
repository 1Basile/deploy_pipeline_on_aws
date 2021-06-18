# Pipeline for java project
Repository containing all necessary files/scripts for maintaining simple pipeline(dev, stage, prod) for example java project.

To deploy infrastructure, you need:
1. Terraform steps:
	* Place terraform/tf_user/.aws/cred with credentials for terraform user in aws.
	* `$ cd terraform`
	* `$ terraform init`
	* `$ terraform apply`

2. Ansible steps:
	* `$ cd ansible`
	* `$ ansible-playbook jenkins.yml`

3. Jenkins steps:
	* Open jenkins web interface on http://{ jenkins_machine_ip }:8080/
	> __jenkins_machine_ip__ can be found in ansible host file.
	

P.s. Jenkins pipeline have to be configured manualy.

