aws_region = "us-east-1"

vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["us-east-1a", "us-east-1b"]
private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24"]

kubernetes_version = "1.31"

# FREE TIER OPTIMIZED: t3.small nodes
node_groups = {
  general = {
    desired_size   = 1
    min_size       = 1
    max_size       = 2
    instance_types = ["t3.small"]
  }
}