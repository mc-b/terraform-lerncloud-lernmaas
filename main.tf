###
#   Ressourcen
#

# KVM Hosts
data "maas_vm_hosts" "vm-hosts" {
  id  = "vm-hosts-01"
}

resource "maas_vm_instance" "vm" {
  count = length(data.maas_vm_hosts.vm-hosts.no) * var.vm_per_host
  kvm_no = data.maas_vm_hosts.vm-hosts.no[count.index % length(data.maas_vm_hosts.vm-hosts.no)]
  hostname = "${split("-", var.module)[0]}-${format("%02d", count.index + var.vm_offset)}-${terraform.workspace}"
  
  cpu_count = var.cores
  memory = var.memory * 1024
  storage = var.storage
  
  zone =  "${var.vpn}"
  description = "${var.description}"
  
  user_data = data.template_file.userdata.rendered  

}
