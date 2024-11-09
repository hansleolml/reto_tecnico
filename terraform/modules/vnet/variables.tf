variable "location" {
  description = "Ubicación del resource group"
  type        = string
}

variable "rg_name" {
  description = "Nombre del resource group"
  type        = string
}

variable "net_sec_group_name" {
  description = "Nombre del network security group"
  type        = string
}

variable "vnet_name" {
  description = "Nombre de la virtual network"
  type        = string
}

variable "vnet_tag_env" {
  description = "Tag de la virtual network"
  type        = string
}

variable "address_space" {
  type        = list(string)
  description = "The address space to be used for the Virtual Network"
  default     = ["10.1.0.0/16"]
}

variable "subnet_name_sub1" {
  description = "Nombre de la subnet"
  type        = string
}

variable "subnet_name_sub2" {
  description = "Nombre de la subnet"
  type        = string
}

variable "subnet_address_prefixes_sub1" {
  type        = list(string)
  description = "The address prefixes to use for the Subnet"
  default     = ["10.1.1.0/24"]
}

variable "subnet_address_prefixes_sub2" {
  type        = list(string)
  description = "The address prefixes to use for the Subnet"
  default     = ["10.1.2.0/24"]
}
