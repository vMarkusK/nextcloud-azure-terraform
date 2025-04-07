terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = " 4.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13.0"
    }
  }
  required_version = "~> 1.11.2"
}

data "azuread_client_config" "this" {}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
  numeric = true
  lower   = true
}

resource "azurerm_resource_group" "nextcloud" {
  name     = local.rg_name
  location = var.location
}

