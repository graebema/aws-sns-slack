locals {
  region                  = "eu-central-1"
  availability_zone_count = 2
  vpc_cidr_block          = "10.10.0.0/16"
  tags = {
    "Environment" = "sns2slack"
  }
}
