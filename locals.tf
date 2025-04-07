# Naming
locals {
  rg_name = format("%s-%s-%s", var.rg_prefix, var.app_name, random_string.suffix.result)
}