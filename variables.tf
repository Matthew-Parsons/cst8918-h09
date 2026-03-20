variable "labelPrefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "myapp"
}

variable "region" {
  description = "Azure region for deployment"
  type        = string
  default     = "CanadaCentral"
}

variable "aks_cluster_name" {
  description = "AKS cluster name"
  type        = string
  default     = "labh09akscluster"
}