locals { 
  # commons
  environment     = "stg"               # 배포 환경 (stg, prd)
  project         = "catcher"
  region          = "ap-northeast-2"    # AWS 리전
  
  # vpc
  vpc_name        = "temp-vpc"     # VPC 이름
  vpc_cidr_block  = "10.0.0.0/16"       # VPC CIDR
  azs             = ["${local.region}a", "${local.region}b"] # AWS AZ
  public_subnets  = [10, 20]            # Public Subnets CIDR
  private_subnets = [1,2]               # Private Subnets CIDR

  # dns
  domain = "dev-alltimecatcher.com"
  record = {
    name = "www"
    type = "A"
    records = "43.202.106.130"
  }
}
