terraform {
  required_version = ">= 1.6.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {}

resource "local_file" "sap_server" {
  filename = "${path.module}/sap-server-01.txt"

  content = <<-EOT
    SAP infrastructure simulation
    Server: ${var.sap_vm_name}
    Environment: ${var.environment}
    Provisioned by: Terraform
  EOT
}
