output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "The security group ID of the EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "node_group_role_arn" {
  description = "The ARN of the node group role"
  value       = module.eks.node_group_role_arn
}
