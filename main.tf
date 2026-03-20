terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

data "azurerm_kubernetes_service_versions" "current" {
  location = azurerm_resource_group.rg.location
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.labelPrefix}-H09-RG"
  location = var.region
}

resource "azurerm_kubernetes_cluster" "app" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
    min_count  = 1
    max_count  = 3
    enable_auto_scaling = true
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = data.azurerm_kubernetes_service_versions.current.latest_version

  network_profile {
    network_plugin = "azure"
  }
}