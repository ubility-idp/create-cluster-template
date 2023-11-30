variable "CLIENT_ID" {
  type      = string
  sensitive = true
}

variable "SECRET" {
  type      = string
  sensitive = true
}

variable "SUBSCRIPTION_ID" {
  type      = string
  sensitive = true
}
variable "TENANT_ID" {
  type      = string
  sensitive = true
}

variable "resource_group_name" {
  type    = string
  default = "${{ values.resource_group }}"
}

variable "resource_group_location" {
  type    = string
  default = "East Us"
}

variable "prefix" {
  type    = string
  default = "aks"
}

variable "kubernetes_cluster_name" {
  type    = string
  default = "${{ values.project_name | lower | replace(' ','') }}"
}

variable "kubernetes_cluster_location" {
  type    = string
  default = "${{ values.region }}"
}

variable "kubernetes_cluster_dns_prefix" {
  type    = string
  default = "${{ values.project_name | lower | replace(' ','') }}"
}

variable "acr_name" {
  type    = string
  default = "${{ values.container_registry }}"
}
