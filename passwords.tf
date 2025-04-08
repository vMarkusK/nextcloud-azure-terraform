resource "random_password" "nextcloud_admin_password" {
  length  = 20
  special = true
}

resource "azurerm_key_vault_secret" "nextcloud_admin_password" {
  name         = "ncadminpassword"
  value        = random_password.nextcloud_admin_password.result
  key_vault_id = azurerm_key_vault.nextcloud.id
  content_type = "password"
}