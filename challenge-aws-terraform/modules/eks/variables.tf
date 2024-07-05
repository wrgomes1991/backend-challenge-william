variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.24"
}

variable "subnets" {
  description = "A list of subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "node_groups" {
  description = "Node group configuration"
  type        = map(any)
  default     = {}
}
