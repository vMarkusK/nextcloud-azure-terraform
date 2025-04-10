resource "azurerm_storage_account" "nextcloud" {
  name                = local.st_name
  resource_group_name = azurerm_resource_group.nextcloud.name
  location            = azurerm_resource_group.nextcloud.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "ZRS"

  public_network_access_enabled    = false
  https_traffic_only_enabled       = true
  min_tls_version                  = "TLS1_2"
  shared_access_key_enabled        = true
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
  sftp_enabled                     = false
  local_user_enabled               = false
  queue_encryption_key_type        = "Account"
  table_encryption_key_type        = "Account"


  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.nextcloud.id
    ]
  }

  customer_managed_key {
    key_vault_key_id          = azurerm_key_vault_key.nextcloud.versionless_id
    user_assigned_identity_id = azurerm_user_assigned_identity.nextcloud.id
  }

  blob_properties {
    container_delete_retention_policy {
      days = 7
    }

  }

  share_properties {
    retention_policy {
      days = 7
    }
  }

  depends_on = [azurerm_key_vault.nextcloud, azurerm_role_assignment.nextcloud, azurerm_role_assignment.nextcloud_extendet]

}

resource "azurerm_storage_share" "nextcloud" {
  name               = "nextcloud-data"
  storage_account_id = azurerm_storage_account.nextcloud.id

  quota       = 100
  access_tier = "Hot"
}

resource "azurerm_private_endpoint" "nextcloud_storage_file" {
  name                = local.st_pe_name
  location            = azurerm_resource_group.nextcloud.location
  resource_group_name = azurerm_resource_group.nextcloud.name
  subnet_id           = azurerm_subnet.nextcloud_pe.id

  private_service_connection {
    name                           = azurerm_storage_account.nextcloud.name
    private_connection_resource_id = azurerm_storage_account.nextcloud.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }

  private_dns_zone_group {
    name                 = azurerm_storage_account.nextcloud.name
    private_dns_zone_ids = [azurerm_private_dns_zone.file_storage.id]
  }
}