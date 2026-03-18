resource "azurerm_kubernetes_cluster" "aks" {
  name = "aks-casopractico2"
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix = "aks-casopractico2"

  default_node_pool {
    name = "default"
    node_count = 1
    vm_size = "Standard_B2as_v2"
  }
  identity {
    type = "SystemAssigned"
  }
  role_based_access_control_enabled = true
  tags = {
    environment = var.environment
  }
}

resource "azurerm_role_assignment" "ra_perm" {
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}