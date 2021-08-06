.PHONY: bootstrap up down tf-plan tf-validate ssh-gen

# Deploys infra
up:
	@echo "Deploying infra"
	cd infra && terraform apply --auto-approve

# Destroys infra
down:
	@echo "Destroying infra"
	cd infra && terraform apply --auto-approve

# Initalise bootstrap
tf-bootstrap:
	cd bootstrap && terraform init
	cd bootstrap && terraform apply --auto-approve

# Shows all the terraform outputs in infra
tf-output:
	@echo "Showing terraform outputs"
	cd infra && terraform output

# Creates an execution for infra
tf-plan:
	@echo "Planning infra before deployment (run 'make up' after)"
	cd infra && terraform plan

# Validates and formats code in infra directory
tf-validate:
	@echo "Validating terraform code"
	cd infra && terraform validate
	@echo "Formatting terraform code"
	cd infra && terraform fmt

# Creates an ssh key for the ec2 instance
ssh-gen:
	@echo "Generating ssh key for ec2 instance"
	mkdir -p ~/.keys
	yes | ssh-keygen -t rsa -b 4096 -f ~/.keys/ec2-key -P ''
	chmod 0644 ~/.keys/ec2-key.pub
	chmod 0600 ~/.keys/ec2-key