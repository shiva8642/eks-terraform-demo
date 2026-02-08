terraform {
  backend "s3" {
    bucket         = "ekshivablast-terraform-state-2024"
    key            = "eks/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-locks"
  }
}
