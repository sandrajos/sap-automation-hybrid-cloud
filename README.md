# SAP Automation Hybrid Cloud Pipeline

This repository contains a complete automation pipeline for SAP deployment using Terraform, Ansible, and shell scripts. It also includes a GitHub Actions workflow to demonstrate CI/CD execution.

## Folder Structure

.github/workflows/sap-pipeline.yml
ansible/
scripts/
terraform/
run_full_pipeline.sh
terraform_1.7.0_linux_amd64.zip
README.md

## Prerequisites

- Python 3.x
- Terraform 1.7.0+
- Ansible
- Bash shell (Linux/Mac/WSL/PowerShell)
- Git

## Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/sap-automation-hybrid-cloud.git
cd sap-automation-hybrid-cloud

## Install Python Dependencies

python3 -m pip install -r requirements.txt

## Make the Pipeline Script Executable

chmod +x run_full_pipeline.sh

## Run the Full Pipeline

./run_full_pipeline.sh

## View Terraform Outputs

To view the Terraform outputs without running the full pipeline again:

cd terraform
terraform output -json > ../terraform_outputs.json
cat ../terraform_outputs.json



