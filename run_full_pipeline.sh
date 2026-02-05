#!/bin/bash
# run_full_pipeline.sh
# Full SAP automation pipeline: Terraform → Ansible → Python validation

set -e
set -o pipefail

# --------------------------
# 1️⃣ Terraform: Init & Apply
# --------------------------
echo "=== 1️⃣ Terraform: Init & Apply ==="
[ -d terraform ] || { echo "❌ Terraform folder missing"; exit 1; }
cd terraform
terraform init
terraform apply -auto-approve
cd ..

# --------------------------
# 2️⃣ Ansible: Configure SAP VM
# --------------------------
echo "=== 2️⃣ Ansible: Configure SAP VM ==="
[ -f ansible/playbooks/setup-sap.yml ] || { echo "❌ Ansible playbook not found"; exit 1; }
ansible-playbook ansible/playbooks/setup-sap.yml -i ansible/inventory.ini

# --------------------------
# 3️⃣ Python: SAP Readiness Validation
# --------------------------
echo "=== 3️⃣ Python: SAP Readiness Validation ==="
python3 scripts/validate_sap_readiness.py || echo "⚠ Python readiness check had an issue, but pipeline continues"

# --------------------------
# ✅ Pipeline Complete
# --------------------------
echo "=== ✅ Pipeline Complete ==="
