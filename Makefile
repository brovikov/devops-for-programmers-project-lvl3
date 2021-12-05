install:
	touch ansible/vault-password
	ansible-galaxy role install -r ansible/requirements.yml
	ansible-galaxy collection install -r ansible/requirements.yml

init:
	terraform -chdir=terraform init

plan:
	terraform -chdir=terraform plan

apply:
	terraform -chdir=terraform apply

destroy:
	terraform -chdir=terraform destroy

lint:
	terraform fmt -check -diff terraform

provision:
	ansible-playbook -i ansible/hosts -v ansible/playbook.yml --vault-password-file ansible/vault-password

deploy:
	ansible-playbook -i ansible/hosts -v ansible/playbook.yml --vault-password-file ansible/vault-password --tags deploy

setup-monitoring:
	ansible-playbook -i ansible/hosts -v ansible/playbook.yml --vault-password-file ansible/vault-password --tags monitoring
	
create-vault:
	ansible-vault create ./ansible/group_vars/all/vault.yml --vault-password-file ansible/vault-password

edit-vault:
	ansible-vault edit ./ansible/group_vars/all/vault.yml --vault-password-file ansible/vault-password

encrypt-vault:
	ansible-vault encrypt ./ansible/group_vars/all/vault.yml --vault-password-file ansible/vault-password

decrypt-vault:
	ansible-vault decrypt ./ansible/group_vars/all/vault.yml --vault-password-file ansible/vault-password

view-vault:
	ansible-vault view ./ansible/group_vars/all/vault.yml --vault-password-file ansible/vault-password
