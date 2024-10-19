
# Map 

variable "machines" {
  type = map(object({
    hostname    = string           # "Hostname" 
    description = optional(string) # "Beschreibung VM"
    memory      = optional(number) # "Memory in GB: bestimmt Instance in der Cloud"
    storage     = optional(number) # "Groesse Disk"
    cores       = optional(number) # "Anzahl CPUs"
    userdata    = string           # "Cloud-init Script"
  }))
}

# Allgemeine Variablen

variable "description" {
  description = "Beschreibung VM"
  type        = string
  default     = "Beschreibung VM"
}

variable "vm_per_host" {
  description = "Anzahl VMs welche pro VM Host angelegt werden sollen"
  type        = number
  default     = 4
}

variable "vm_offset" {
  description = "Offset fuer die erste Host-IP Nummer"
  type        = number
  default     = 10
}

variable "memory" {
  description = "Memory in GB: bestimmt Instance in der Cloud"
  type        = number
  default     = 2
}

variable "storage" {
  description = "Groesse Disk"
  type        = number
  default     = 12
}

variable "cores" {
  description = "Anzahl CPUs"
  type        = number
  default     = 1
}

variable "ports" {
  description = "Ports welche in der Firewall geoeffnet sind"
  type        = list(number)
  default     = [22, 80]
}

# Verarbeiten der userdata-Datei im Modul
data "template_file" "userdata" {
  for_each = { for idx, vm in local.expanded_machines : "${vm.type}-${vm.index}" => vm }
  template = file(each.value.userdata)
}

# Zugriffs Informationen

variable "url" {
  description = "Evtl. URL fuer den Zugriff auf das API des Racks Servers"
  type        = string
}

variable "key" {
  description = "API Key, Token etc. fuer Zugriff"
  type        = string
  sensitive   = true
}

variable "vpn" {
  description = "Optional VPN welches eingerichtet werden soll"
  type        = string
  default     = "default"
}

