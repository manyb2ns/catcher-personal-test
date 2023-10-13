terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
      bucket         = "catcher-tf-backend" # s3 bucket 이름
      key            = "terraform.tfstate" # s3 내에서 저장되는 경로를 의미합니다.
      region         = "ap-northeast-2"  
      encrypt        = true
      # dynamodb_table = "terraform-lock"
  }
}

# Configure the AWS Provider
provider "aws" {
  # shared_config_files      = ["/Users/dboo/Documents/Project/Catcher/.aws/config"]
  # shared_credentials_files = ["/Users/dboo/Documents/Project/Catcher/.aws/credentials"]
  # profile                  = "default"
  access_key     = ${{secrets.AWS_ACCESS_KEY_ID}}
  secret_key = ${{secrets.AWS_SECRET_ACCESS_KEY}}
  region = ${{secrets.AWS_REGION}
}

### VPC ###
module "vpc" {
  source          = "../../modules/vpc"

  project         = local.project
  environment     = local.environment
  vpc_name        = local.vpc_name
  vpc_cidr_block  = local.vpc_cidr_block
  private_subnet_num = local.private_subnets
  public_subnet_num  = local.public_subnets
}

### DNS ###
module "dns" {
  source          = "../../modules/dns"

  project = local.project
  environment = local.environment
  domain = local.domain
  vpc_id = module.vpc.vpc_id
  record = local.record
}

# ### EKS ###
# module "eks" {
#   source          = "../../modules/eks"

#   project = local.project
#   environment = local.environment
#   vpc_id = module.vpc.vpc_id
#   pv_subnet_ids = module.vpc.pv_subnet_ids
# }