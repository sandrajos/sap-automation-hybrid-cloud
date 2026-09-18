output "sap_vm_name" {
  description = "Simulated SAP server hostname"
  value       = var.sap_vm_name
}

output "environment" {
  description = "Deployment environment"
  value       = var.environment
}

output "sap_server_file" {
  description = "Path to the simulated server artifact"
  value       = local_file.sap_server.filename
}
