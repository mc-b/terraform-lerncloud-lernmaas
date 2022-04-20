###
# Separate Datei wegen Defaultwerten Terraform

terraform {
  required_providers {
    maas = {
      source = "mc-b/lernmaas"
      version = "~>1.0.1"
    }
  }
}