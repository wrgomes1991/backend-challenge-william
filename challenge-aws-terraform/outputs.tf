output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "security_group_id" {
  value = module.security_group.security_group_id
}

output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}