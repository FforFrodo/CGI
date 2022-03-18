# In Azure, all infrastructure elements such as virtual machines, 
# storage, and our Kubernetes cluster need to be attached to a resource group.

resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location
}

# Enable role to pull docker image from Azure container registry
resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true
}

# Azure container reistery creation, Disabling admin password is recommended
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks-rg.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = var.cluster_name

# define VM size for nodes (Standard_D2as_v5 = 2 CPU & 8 RAM)
  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_D2as_v5"
    type                = "VirtualMachineScaleSets"
    // availability_zones  = [1, 2, 3] # enabling results in allocation error for free account
    // enable_auto_scaling = false
  }
# Credentials: Azure will automatically create required roles & permissions
  identity {
    type = "SystemAssigned"
  }

# For enabling AKS ingress
  // addon_profile {
  //   http_application_routing {
  //     enabled = true
  //   }
  // }
}
