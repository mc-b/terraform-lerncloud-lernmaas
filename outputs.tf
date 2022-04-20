###
#   Outputs wie IP-Adresse und DNS Name
#  

/*
output "ip_vm" {
  value = "${var.vpn}.${maas_vm_instance.vm.hostname}"
  description = "The IP address of the server instance."
}

output "fqdn_vm" {
  value = maas_vm_instance.vm.hostname 
  description = "The FQDN of the server instance."
}

output "description" {
  value = var.description 
  description = "Description VM"
}

*/