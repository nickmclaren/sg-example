TERRAFORM ?= terraform
BRANCH_NAME ?= dev

init:
	$(TERRAFORM) init -backend-config=./init-tfvars/$(BRANCH_NAME).tfvars 

plan:
	$(TERRAFORM) plan -var-file=./apply-tfvars/$(BRANCH_NAME).tfvars 

apply:
	$(TERRAFORM) apply -var-file=./apply-tfvars/$(BRANCH_NAME).tfvars 

destroy:
	$(TERRAFORM) destroy -var-file=./apply-tfvars/$(BRANCH_NAME).tfvars 