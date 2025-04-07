resource "time_static" "current" {}

resource "azurerm_user_assigned_identity" "nextcloud" {
  name                = local.uai_name
  resource_group_name = azurerm_resource_group.nextcloud.name
  location            = azurerm_resource_group.nextcloud.location
}

resource "azurerm_key_vault" "nextcloud" {
  name                = local.kv_name
  resource_group_name = azurerm_resource_group.nextcloud.name
  location            = azurerm_resource_group.nextcloud.location

  sku_name                   = "standard"
  tenant_id                  = data.azuread_client_config.this.tenant_id
  enable_rbac_authorization  = true
  purge_protection_enabled   = true
  soft_delete_retention_days = 7
}

resource "azurerm_role_assignment" "nextcloud" {
  scope                = azurerm_key_vault.nextcloud.id
  role_definition_name = "Key Vault Crypto User"
  principal_id         = azurerm_user_assigned_identity.nextcloud.principal_id
}

resource "azurerm_key_vault_key" "nextcloud" {
  name         = local.key_name
  key_vault_id = azurerm_key_vault.nextcloud.id

  key_type = "RSA"
  key_size = 4096
  key_opts = ["wrapKey", "unwrapKey"]

  expiration_date = timeadd(formatdate("YYYY-MM-DD'T'HH:mm:ss'Z'", time_static.current.rfc3339), "8760h")

  rotation_policy {
    automatic {
      time_before_expiry = "P60D"
    }

    expire_after         = "P365D"
    notify_before_expiry = "P30D"
  }

  lifecycle {
    ignore_changes = [expiration_date]
  }
}