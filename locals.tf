# Naming
locals {
  rg_name  = format("%s-%s-%s", var.rg_prefix, var.app_name, random_string.suffix.result)
  uai_name = format("%s-%s-%s", var.uai_prefix, var.app_name, random_string.suffix.result)
  kv_name  = format("%s-%s-%s", var.kv_prefix, var.app_name, random_string.suffix.result)
  key_name = format("%s-%s-%s", var.key_prefix, var.app_name, random_string.suffix.result)

}