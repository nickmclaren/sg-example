TERRAFORM ?= terraform
TF_VAR_env_name ?= dev

init:
	$(TERRAFORM) init -backend-config=./init-tfvars/$(TF_VAR_env_name).tfvars 

plan:
	$(TERRAFORM) plan -var-file=./apply-tfvars/$(TF_VAR_env_name).tfvars 

apply:
	$(TERRAFORM) apply -var-file=./apply-tfvars/$(TF_VAR_env_name).tfvars 

destroy:
	$(TERRAFORM) destroy -var-file=./apply-tfvars/$(TF_VAR_env_name).tfvars 