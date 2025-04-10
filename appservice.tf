resource "azurerm_service_plan" "nextcloud" {
  name                   = local.asp_name
  resource_group_name    = azurerm_resource_group.nextcloud.name
  location               = azurerm_resource_group.nextcloud.location
  os_type                = "Linux"
  sku_name               = "P0v3"
  worker_count           = 3
  zone_balancing_enabled = true
}

resource "azurerm_linux_web_app" "nextcloud" {
  name                = local.app_name
  resource_group_name = azurerm_resource_group.nextcloud.name
  location            = azurerm_service_plan.nextcloud.location
  service_plan_id     = azurerm_service_plan.nextcloud.id

  virtual_network_subnet_id = azurerm_subnet.nextcloud_asp.id

  https_only                                     = true
  ftp_publish_basic_authentication_enabled       = false
  webdeploy_publish_basic_authentication_enabled = false

  storage_account {
    name         = var.app_name
    account_name = azurerm_storage_account.nextcloud.name
    share_name   = azurerm_storage_share.nextcloud.name
    access_key   = azurerm_storage_account.nextcloud.primary_access_key
    mount_path   = "/var/www/html/data"
    type         = "AzureFiles"
  }

  logs {
    detailed_error_messages = false
    failed_request_tracing  = false

    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
  }

  site_config {
    always_on                               = true
    container_registry_use_managed_identity = false
    default_documents                       = ["Default.htm", "Default.html", "Default.asp", "index.htm", "index.html", "iisstart.htm", "default.aspx", "index.php", "hostingstart.html"]
    ftps_state                              = "Disabled"
    http2_enabled                           = false
    load_balancing_mode                     = "LeastRequests"
    managed_pipeline_mode                   = "Integrated"
    minimum_tls_version                     = "1.2"
    worker_count                            = 1
    vnet_route_all_enabled                  = true
    application_stack {
      docker_image_name   = "nextcloud:latest"
      docker_registry_url = "https://index.docker.io"
    }
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = true
    WEBSITES_CONTAINER_START_TIME_LIMIT = 1800
    NEXTCLOUD_ADMIN_USER                = var.nextcloud_admin_username
    NEXTCLOUD_ADMIN_PASSWORD            = random_password.nextcloud_admin_password.result
    REDIS_HOST                          = azurerm_redis_cache.nextcloud.hostname
    REDIS_HOST_PASSWORD                 = azurerm_redis_cache.nextcloud.primary_access_key
    REDIS_HOST_PORT                     = azurerm_redis_cache.nextcloud.ssl_port
    MYSQL_DATABASE                      = azurerm_mysql_flexible_database.nextcloud.name
    MYSQL_USER                          = var.mysql_admin_username
    MYSQL_PASSWORD                      = random_password.mysql_admin_password.result
    MYSQL_HOST                          = azurerm_mysql_flexible_server.nextcloud.fqdn
    #SQLITE_DATABASE = "nextcloud"
  }
}