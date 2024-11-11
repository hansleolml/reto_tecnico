variable "rg_net_01_name" {
  description = "El nombre del grupo de recursos de las VNET y Subnet a crear."
  type        = string
}

variable "rg_vm_01_name" {
  description = "El nombre del grupo de recursos de las VM a crear."
  type        = string
}

variable "nsg_01_name" {
  description = "El nombre del grupo de recursos de las VM a crear."
  type        = string
}

variable "rg_aks_01_name" {
  description = "El nombre del grupo de recursos de las VM a crear."
  type        = string
}

variable "location" {
  description = "La ubicación donde se creará el grupo de recursos."
  type        = string
}

variable "location_aks" {
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

variable "vnet_01_name" {
  description = "Nombre de la virtual network"
  type        = string
}

variable "vnet_02_name" {
  description = "Nombre de la virtual network"
  type        = string
}

variable "subnet_01_name" {
  description = "Nombre de la subnet"
  type        = string
}

variable "subnet_02_name" {
  description = "Nombre de la subnet"
  type        = string
}
