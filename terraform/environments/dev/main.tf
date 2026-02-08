terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  environment = "dev"
  common_tags = {
    Environment = local.environment
    ManagedBy   = "Terraform"
    Project     = "EKS-Demo"
    Owner       = "DevOps-Team"
  }
}

# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  vpc_name           = "${local.environment}-vpc"
  vpc_cidr           = var.vpc_cidr
  azs                = var.availability_zones
  private_subnets    = var.private_subnet_cidrs
  public_subnets     = var.public_subnet_cidrs
  enable_nat_gateway = true
  single_nat_gateway = true  # Cost optimization for dev

  tags = local.common_tags
}

# EKS Module
module "eks" {
  source = "../../modules/eks"

  cluster_name    = "${local.environment}-cluster"
  cluster_version = var.kubernetes_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = concat(module.vpc.private_subnet_ids, module.vpc.public_subnet_ids)

  node_groups = var.node_groups

  tags = local.common_tags

  depends_on = [module.vpc]
}