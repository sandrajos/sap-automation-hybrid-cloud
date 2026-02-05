variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "sap_vm_name" {
  description = "SAP VM hostname"
  type        = string
  default     = "sap-server-01"
}
