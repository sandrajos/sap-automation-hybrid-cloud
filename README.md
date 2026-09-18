# SAP Automation & Infrastructure Readiness Pipeline

A portfolio DevOps project demonstrating infrastructure automation, configuration validation, host-readiness checks, and CI/CD using **Terraform, Ansible, Python, and GitHub Actions**.

> **Scope:** This project uses Terraform to simulate SAP infrastructure locally. It does **not** deploy a real SAP system or provision real cloud infrastructure. The focus is on automation workflow design, validation, and CI/CD practices.

## Architecture

```text
                    GitHub Actions
                          |
                          v
                +---------------------+
                | Terraform Validation|
                +----------+----------+
                           |
                           v
                +---------------------+
                | Terraform Apply     |
                | Local Infrastructure |
                | Simulation           |
                +----------+----------+
                           |
                           v
                +---------------------+
                | Ansible Validation  |
                | Configuration Check |
                +----------+----------+
                           |
                           v
                +---------------------+
                | Python Readiness    |
                | CPU / RAM / Disk    |
                | Port Validation     |
                +----------+----------+
                           |
                           v
                    Validation Result
```

## What This Project Demonstrates

* Infrastructure as Code with Terraform
* Configuration automation with Ansible
* Python-based infrastructure readiness validation
* GitHub Actions CI
* Automated Terraform formatting and validation
* Fail-fast validation and pipeline sequencing
* Dependency management
* Reproducible automation workflows
* Basic SAP HANA host-readiness concepts

## Pipeline Flow

The automation follows this sequence:

### 1. Terraform

Terraform initializes and applies a local infrastructure simulation.

The `local` provider creates a generated server artifact containing:

* simulated SAP server name
* deployment environment
* Terraform provisioning information

Example:

```text
SAP infrastructure simulation
Server: sap-server-01
Environment: dev
Provisioned by: Terraform
```

Terraform variables include validation for:

* deployment environment: `dev`, `test`, or `prod`
* valid lowercase server names

### 2. Ansible

Ansible validates that the Terraform-generated server artifact exists.

The playbook:

* checks the generated artifact
* fails when the artifact is missing
* confirms successful provisioning validation

The inventory uses a local connection:

```ini
[sap_servers]
sap-server-01 ansible_host=127.0.0.1 ansible_connection=local
```

### 3. Python Readiness Validation

The Python script performs basic host-readiness checks using `psutil`.

Current checks include:

* operating system
* physical CPU cores
* available memory
* free disk space
* HANA SQL port `30015`

The configured readiness thresholds are:

| Check      |          Threshold |
| ---------- | -----------------: |
| CPU        | ≥ 4 physical cores |
| Memory     |            ≥ 16 GB |
| Disk       |      ≥ 100 GB free |
| Port 30015 |          Available |

The script returns a non-zero exit code when a required check fails.

## GitHub Actions CI

The GitHub Actions workflow runs on an Ubuntu runner and performs:

1. Repository checkout
2. Python dependency installation
3. Ansible installation
4. Terraform installation
5. Terraform formatting check
6. Terraform initialization
7. Terraform validation
8. Full automation pipeline execution

Workflow file:

```text
.github/workflows/sap-pipeline.yml
```

The workflow requires only:

```yaml
permissions:
  contents: read
```

No cloud credentials or deployment secrets are required.

## Repository Structure

```text
sap-automation-hybrid-cloud/
│
├── .github/
│   └── workflows/
│       └── sap-pipeline.yml
│
├── ansible/
│   ├── inventory.ini
│   └── playbooks/
│       └── setup-sap.yml
│
├── scripts/
│   └── validate_sap_readiness.py
│
├── terraform/
│   ├── main.tf
│   ├── outputs.tf
│   ├── requirements.txt
│   ├── variables.tf
│   └── .terraform.lock.hcl
│
├── .gitignore
├── README.md
└── run_full_pipeline.sh
```

## Local Prerequisites

For the complete pipeline, use an environment that provides:

* Python 3.x
* Terraform 1.7+
* Ansible
* Bash
* Git

Python dependencies:

```bash
python3 -m pip install -r terraform/requirements.txt
```

The Python dependency currently used is:

```text
psutil
```

## Run the Pipeline

From the repository root:

```bash
chmod +x run_full_pipeline.sh
./run_full_pipeline.sh
```

The script executes:

```text
Terraform → Ansible → Python
```

Each stage must complete successfully before the next stage runs.

## Terraform Commands

Initialize Terraform:

```bash
terraform -chdir=terraform init
```

Validate the configuration:

```bash
terraform -chdir=terraform validate
```

Check formatting:

```bash
terraform -chdir=terraform fmt -check
```

Apply the local simulation:

```bash
terraform -chdir=terraform apply
```

View outputs:

```bash
terraform -chdir=terraform output
```

## Project Scope and Limitations

This is a **portfolio and learning project**.

It demonstrates the automation workflow around infrastructure provisioning and SAP host readiness, but it does not:

* install SAP software
* install SAP HANA
* provision an actual SAP server
* create AWS/Azure/GCP resources
* configure a production SAP landscape
* connect to a real SAP environment
* perform production deployment

The Terraform layer intentionally uses the HashiCorp `local` provider so the project can demonstrate Infrastructure as Code without requiring paid cloud infrastructure.

## DevOps Concepts Demonstrated

This project combines several practical DevOps concepts:

**Infrastructure as Code**

Terraform defines and validates infrastructure configuration.

**Configuration Automation**

Ansible validates the expected infrastructure state.

**Automated Validation**

Python checks host resources and network-port availability.

**CI/CD**

GitHub Actions automatically validates the project on repository changes.

**Fail-Fast Execution**

Each pipeline stage must succeed before the next stage continues.

**Reproducibility**

Dependencies, Terraform provider versions, validation rules, and CI steps are defined in version-controlled files.

## Technologies

* Terraform
* Ansible
* Python
* psutil
* Bash
* Git
* GitHub Actions
* Infrastructure as Code
* CI/CD
* Linux automation concepts
* SAP HANA host-readiness concepts

## Portfolio Context

This project was created to demonstrate practical Cloud/DevOps skills through an automated infrastructure-validation workflow.

It focuses on **Infrastructure as Code, configuration automation, CI/CD, validation, and reliability-oriented automation** rather than claiming a production SAP deployment.
