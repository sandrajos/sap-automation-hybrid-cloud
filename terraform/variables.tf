variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}

variable "sap_vm_name" {
  description = "Simulated SAP server hostname"
  type        = string
  default     = "sap-server-01"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.sap_vm_name))
    error_message = "SAP server name must contain only lowercase letters, numbers, and hyphens."
  }
}
