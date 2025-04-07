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

variable "uai_prefix" {
  description = "The Azure User Managed Identity name prefix"
  type        = string
  default     = "uai"
}

variable "kv_prefix" {
  description = "The Azure Key Vault name prefix"
  type        = string
  default     = "kv"
}

variable "key_prefix" {
  description = "The Azure Key Vault Key name prefix"
  type        = string
  default     = "key"
}