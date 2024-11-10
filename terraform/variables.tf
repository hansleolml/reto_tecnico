variable "rg_net_01_name" {
  description = "El nombre del grupo de recursos de las VNET y Subnet a crear."
  type        = string
}

variable "rg_vm_01_name" {
  description = "El nombre del grupo de recursos de las VM a crear."
  type        = string
}

variable "location" {
  description = "La ubicación donde se creará el grupo de recursos."
  type        = string
}

variable "tags" {
  description = "Etiquetas opcionales para aplicar al grupo de recursos."
  type        = map(string)
  default = {
    environment = "Dev"
    team        = "IT"
  }
}

variable "vnet_name" {
  description = "Nombre de la virtual network"
  type        = string
}

variable "subnet_name" {
  description = "Nombre de la subnet"
  type        = string
}
