variable "resource_group_name" {
  description = "El nombre del grupo de recursos a crear."
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

variable "rg_vnet_name" {
  description = "Nombre del resource group"
  type        = string
}


