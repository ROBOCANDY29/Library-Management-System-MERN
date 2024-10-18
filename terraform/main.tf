# Configure the Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = "23035d1f-133c-44b5-b2ad-b3aef17baaa1"
}

# Variable Declarations
variable "dockerhub_username" {
  description = "The username for Docker Hub."
  type        = string
  default     = "kdroid29"  # Your Docker Hub username
}

variable "dockerhub_password" {
  description = "The password for Docker Hub."
  type        = string
  default="dckr_pat_wmPzy8n6qwHQRY3mKvF_eYv5OHs"
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "flexi2914"  # Specify your resource group name
  location = "East US"     # Specify your location
}

# Public IP
resource "azurerm_public_ip" "frontend" {
  name                = "frontendPublicIP"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}

# Backend Container Group
resource "azurerm_container_group" "backend" {
  name                = "backend-container"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  ip_address_type     = "Public"
  os_type             = "Linux"

  container {
    name   = "backend"
    image  = "${var.dockerhub_username}/your-backend-image:latest"  # Update with your Docker Hub image
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 4000
      protocol = "TCP"
    }
  }

  image_registry_credential {
    server   = "index.docker.io"
    username = var.dockerhub_username
    password = var.dockerhub_password
  }
}

# Frontend Container Group
resource "azurerm_container_group" "frontend" {
  name                = "frontend-container"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  ip_address_type     = "Public"
  os_type             = "Linux"

  container {
    name   = "frontend"
    image  = "${var.dockerhub_username}/your-frontend-image:latest"  # Update with your Docker Hub image
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 4000
      protocol = "TCP"
    }
  }

  image_registry_credential {
    server   = "index.docker.io"
    username = var.dockerhub_username
    password = var.dockerhub_password
  }
}
