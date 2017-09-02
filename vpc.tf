module "vpc" {
  source = "github.com/terraform-community-modules/tf_aws_vpc"

  name = "${var.env_name}-${var.region}-vpc"

  cidr = "${var.cidr}"
  private_subnets = ["${split(",",var.private_subnets)}"]
  public_subnets  = ["${split(",",var.public_subnets)}"]

  enable_nat_gateway = "true"

  azs = ["${split(",",var.azs)}"]

  tags {
    "ManagedBy" = "Terraform"
    "Name" = "${var.env_name}-${var.region}-vpc"
  }
}