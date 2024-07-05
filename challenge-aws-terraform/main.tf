provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "challenge-tfstate-bucket"
}
 
terraform {
  backend "s3" {
    bucket = "challenge-tfstate-bucket"
    key    = "terraform.tfstate"
    region = var.aws_region
  }
}

module "vpc" {
  source                  = "./modules/vpc"
  cidr_block              = "10.0.0.0/16"
  public_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  name                    = "challenge-vpc"
}

module "security_group" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
  name   = "challenge-security-group"
}

module "eks" {
  source         = "./modules/eks"
  cluster_name   = "challenge-eks-cluster"
  cluster_version = "1.24"
  subnets        = module.vpc.public_subnets
  vpc_id         = module.vpc.vpc_id
  node_groups    = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
      key_name         = "challenge-key-pair"
    }
  }
}

module "ecr" {
  source              = "./modules/ecr"
  name                = "challenge-ecr-repo"
  image_tag_mutability = "IMMUTABLE"
}