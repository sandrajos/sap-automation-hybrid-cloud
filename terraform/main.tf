terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "local" {}

resource "local_file" "sap_vm" {
  filename = "${path.module}/sap-server-01.txt"
  content  = "SAP VM provisioned successfully"
}
