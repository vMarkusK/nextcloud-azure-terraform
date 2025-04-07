variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "The location of all Azure Ressources"
  type        = string
  default     = "swedencentral"
}

variable "app_name" {
  description = "The Application name"
  type        = string
  default     = "nextcloud"
}

variable "rg_prefix" {
  description = "The Azure Ressource Group name prefix"
  type        = string
  default     = "rg"
}