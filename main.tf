# Data Source, um die Anzahl der Hosts zu erhalten
data "maas_vm_hosts" "vm-hosts" {
  id = "vm-hosts-01"
}

# Lokale Variable, um die Maschinen mit der Anzahl der Instanzen zu kombinieren
locals {
  # Diese Schleife erstellt für jeden Typ so viele Einträge, wie in der Data Source angegeben
  expanded_machines = flatten([
    for machine_type, machine in var.machines : [
      for i in range(length(data.maas_vm_hosts.vm-hosts.no) * var.vm_per_host) : {
        type        = machine_type
        index       = i + 1
        hostname    = machine.hostname
        description = machine.description
        cores       = coalesce(machine.cores, var.cores)
        memory      = coalesce(machine.memory, var.memory)
        storage     = coalesce(machine.storage, var.storage)
        userdata    = machine.userdata
      }
    ]
  ])
}

# Nun verwenden wir "for_each", um die VMs zu erstellen basierend auf der expandierten Liste
resource "maas_vm_instance" "vm" {
  for_each = { for idx, vm in local.expanded_machines : "${vm.type}-${vm.index}" => vm }

  kvm_no = data.maas_vm_hosts.vm-hosts.no[each.value.index % length(data.maas_vm_hosts.vm-hosts.no)]

  hostname    = "${each.value.hostname}-${format("%02d", each.value.index)}"
  description = each.value.description
  cpu_count   = each.value.cores
  memory      = each.value.memory * 1024
  storage     = each.value.storage

  user_data = each.value.userdata["${each.value.type}-${each.value.index}"]
  zone      = var.vpn
}
