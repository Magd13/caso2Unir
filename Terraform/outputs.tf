output "vm_public_ip" {
  value = azurerm_public_ip.vm_ip.ip_address
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
output "acr_admin_password" {
  description = "Contraseña del ACR. Consúltala con: terraform output -raw acr_admin_password"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}
output "acr_admin_username" {
  description = "Usuario administrador del ACR"
  value       = azurerm_container_registry.acr.admin_username
}

output "ssh_private_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}
output "aks_cluster_name" {
  description = "Nombre del clúster AKS"
  value       = azurerm_kubernetes_cluster.aks.name
}