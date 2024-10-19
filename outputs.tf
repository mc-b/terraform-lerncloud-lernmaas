###
#   Outputs wie IP-Adresse und DNS Name
#  

output "ip_vm" {
  value = { for key, vm in maas_vm_instance.vm :
    key => try(
      format(
        "%s.%s",
        replace(join(".", slice(split("-", var.machines[key].vpn), 0, 3)), "-", "."),
        element(slice(split("-", vm.hostname), 1, 2), 0)
      ),
      vm.ip_addresses
    )
  }
  description = "The IP address of the server instance."
}

output "fqdn_vm" {
  value       = { for key, vm in maas_vm_instance.vm : key => "${vm.hostname}.maas" }
  description = "The FQDN of the server instance."
}

output "description" {
  value       = { for key, machine in var.machines : key => machine.description }
  description = "Description of each VM."
}

