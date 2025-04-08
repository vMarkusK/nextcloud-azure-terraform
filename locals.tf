# Naming
locals {
  rg_name       = format("%s-%s-%s", var.rg_prefix, var.app_name, random_string.suffix.result)
  vnet_name     = format("%s-%s-%s", var.vnet_prefix, var.app_name, random_string.suffix.result)
  uai_name      = format("%s-%s-%s", var.uai_prefix, var.app_name, random_string.suffix.result)
  kv_name       = format("%s-%s-%s", var.kv_prefix, var.app_name, random_string.suffix.result)
  key_name      = format("%s-%s-%s", var.key_prefix, var.app_name, random_string.suffix.result)
  st_name       = format("%s%s%s", var.st_prefix, var.app_name, random_string.suffix.result)
  st_pe_name    = format("%s-%s", var.pe_prefix, local.st_name)
  asp_name      = format("%s-%s-%s", var.asp_prefix, var.app_name, random_string.suffix.result)
  app_name      = format("%s-%s-%s", var.app_prefix, var.app_name, random_string.suffix.result)
  redis_name    = format("%s-%s-%s", var.redis_prefix, var.app_name, random_string.suffix.result)
  redis_pe_name = format("%s-%s", var.pe_prefix, local.redis_name)
}