###
# Separate Datei wegen Defaultwerten Terraform

terraform {
  required_providers {
    maas = {
      source  = "mc-b/lernmaas"
      version = ">=2.4.1"
    }
  }
}