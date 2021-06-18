# Deploy pipeline on AWS :octocat:
Repository containing all necessary files/scripts for maintaining jenkins pipeline(dev, stage, prod).

To deploy infrastructure, you need:

0. Dependencies:
	* Python in PATH (how to add python interpretattor ot PATH, you can read [here](https://www.edureka.co/blog/add-python-to-path/))
	* [Terraform](https://www.terraform.io/downloads.html)
	* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

2. Terraform steps:
	* _Place **terraform/tf_user/.aws/cred** with credentials for terraform user in aws._
	* _If needed, change dev/stage/prod machines **amount** and **ami_id** in [variables.tf](terraform/variables.tf)_
	* `$ cd terraform`
	* `$ terraform init`
	* `$ terraform apply`

2. Ansible steps:
	* `$ cd ansible`
	* _If needed, you can add additional jenkins pluggins, place them in [plugins.yml](ansible/roles/install-jenkins-master/vars/plugins.yml)_
	* _If needed, you can change some pre-defined constants, see [defaults](ansible/roles/install-jenkins-master/defaults/main.yml)
	* `$ ansible-playbook jenkins.yml`

3. Jenkins steps:
	* _Open jenkins web interface on http://{ jenkins_machine_ip }:8080/_
	> __jenkins_machine_ip__ can be found in [ansible host file](ansible/inventory/hosts.cfg) (there's no such file in repo, terraform generate it).
	* _Update nodes private keys if needed._

__Congrads, now you have deployed CI/CD pipline on AWS.
P.s. Jenkins pipeline have to be configured manualy :heart:.__

