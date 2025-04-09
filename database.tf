resource "azurerm_mysql_flexible_server" "nextcloud" {
  name                = local.mysql_name
  resource_group_name = azurerm_resource_group.nextcloud.name
  location            = azurerm_resource_group.nextcloud.location
  sku_name            = "B_Standard_B1ms"

  administrator_login    = var.mysql_admin_username
  administrator_password = random_password.mysql_admin_password.result

  public_network_access = "Disabled"
  backup_retention_days = 7

  #high_availability {
  #  mode = "ZoneRedundant"
  #}

  identity {
    identity_ids = [azurerm_user_assigned_identity.nextcloud.id]
    type         = "UserAssigned"
  }

  customer_managed_key {
    key_vault_key_id                  = azurerm_key_vault_key.nextcloud.id
    primary_user_assigned_identity_id = azurerm_user_assigned_identity.nextcloud.id
  }

  depends_on = [azurerm_key_vault.nextcloud, azurerm_role_assignment.nextcloud]
}

resource "azurerm_private_endpoint" "nextcloud_mysql" {
  name                = local.mysql_pe_name
  location            = azurerm_resource_group.nextcloud.location
  resource_group_name = azurerm_resource_group.nextcloud.name
  subnet_id           = azurerm_subnet.nextcloud_pe.id

  private_service_connection {
    name                           = azurerm_mysql_flexible_server.nextcloud.name
    private_connection_resource_id = azurerm_mysql_flexible_server.nextcloud.id
    is_manual_connection           = false
    subresource_names              = ["mysqlServer"]
  }

  private_dns_zone_group {
    name                 = azurerm_mysql_flexible_server.nextcloud.name
    private_dns_zone_ids = [azurerm_private_dns_zone.mysql.id]
  }
}

resource "azurerm_mysql_flexible_database" "nextcloud" {
  name                = "nextcloud"
  resource_group_name = azurerm_resource_group.nextcloud.name
  server_name         = azurerm_mysql_flexible_server.nextcloud.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_general_ci"
}