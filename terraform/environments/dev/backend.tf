terraform {
  backend "s3" {
    bucket         = "ekshivablast-terraform-state-2024"  # Change this!
    key            = "eks/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true
  }
}