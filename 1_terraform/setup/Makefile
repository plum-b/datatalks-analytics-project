# Makefile for Terraform automation

TF_CMD := terraform
TF_DIR := .
TF_ARGS :=

.PHONY: help infra-init infra-plan infra-apply infra-destroy infra-validate infra-fmt infra-show

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Infrastructure

infra-init: ## Initialize Terraform workspace
	@echo "Initializing Terraform..."
	@cd $(TF_DIR) && $(TF_CMD) init $(TF_ARGS)

infra-plan: ## Show execution plan
	@echo "Generating Terraform plan..."
	@cd $(TF_DIR) && $(TF_CMD) plan $(TF_ARGS)

infra-apply: ## Apply Terraform configuration
	@echo "Applying Terraform configuration..."
	@cd $(TF_DIR) && $(TF_CMD) apply -auto-approve $(TF_ARGS)

infra-validate: ## Validate Terraform configuration
	@echo "Validating Terraform configuration..."
	@cd $(TF_DIR) && $(TF_CMD) validate $(TF_ARGS)

infra-destroy: ## Destroy Terraform-managed infrastructure
	@echo "Destroying infrastructure..."
	@cd $(TF_DIR) && $(TF_CMD) destroy -auto-approve $(TF_ARGS)

infra-fmt: ## Format Terraform files
	@echo "Formatting Terraform files..."
	@cd $(TF_DIR) && $(TF_CMD) fmt -recursive

infra-show: ## Show current state
	@echo "Showing current state..."
	@cd $(TF_DIR) && $(TF_CMD) show $(TF_ARGS)