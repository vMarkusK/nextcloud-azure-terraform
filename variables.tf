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

variable "vnet_prefix" {
  description = "The Azure VNet name prefix"
  type        = string
  default     = "vnet"
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

variable "st_prefix" {
  description = "The Azure Storage Accountname prefix"
  type        = string
  default     = "st"
}

variable "pe_prefix" {
  description = "The Azure Private Endpoint prefix"
  type        = string
  default     = "pe"
}

variable "asp_prefix" {
  description = "The Azure App Service Plan prefix"
  type        = string
  default     = "asp"
}

variable "app_prefix" {
  description = "The Azure Web App prefix"
  type        = string
  default     = "app"
}

variable "redis_prefix" {
  description = "The Azure Redis Cache prefix"
  type        = string
  default     = "redis"
}

variable "mysql_prefix" {
  description = "The Azure MySQL prefix"
  type        = string
  default     = "mysql"
}

variable "vnet_addressspace" {
  description = "The VNet Address Space"
  type        = list(string)
  default     = ["172.20.1.0/24"]
}

variable "nextcloud_admin_username" {
  description = "NextCloud Admin Username for the UI"
  type        = string
  default     = "ncadmin"
}

variable "mysql_admin_username" {
  description = "mysql Admin Username"
  type        = string
  default     = "ncdbadmin"
}