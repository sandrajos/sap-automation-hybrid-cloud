#!/usr/bin/env bash

set -euo pipefail

echo "=============================================="
echo " SAP Automation Validation Pipeline"
echo " Terraform -> Ansible -> Python"
echo "=============================================="

echo ""
echo "=== 1. Terraform: Init & Apply ==="

if [[ ! -d "terraform" ]]; then
    echo "ERROR: Terraform directory not found."
    exit 1
fi

terraform -chdir=terraform init -input=false
terraform -chdir=terraform apply -auto-approve -input=false

echo ""
echo "=== 2. Ansible: Configuration Validation ==="

if [[ ! -f "ansible/playbooks/setup-sap.yml" ]]; then
    echo "ERROR: Ansible playbook not found."
    exit 1
fi

ansible-playbook ansible/playbooks/setup-sap.yml -i ansible/inventory.ini

echo ""
echo "=== 3. Python: SAP Readiness Validation ==="

python3 scripts/validate_sap_readiness.py

echo ""
echo "=============================================="
echo " Pipeline completed successfully"
echo "=============================================="
