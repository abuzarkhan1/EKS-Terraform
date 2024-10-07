data "aws_vpc" "default_vpc" {
  default = true
}

data "localos_public_ip" "users_ip" {
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
  filter {
    name = "availability-zone"
    values = [
      "${var.aws_region}a",
      "${var.aws_region}b",
      "${var.aws_region}c"
    ]
  }
}

data "aws_ssm_parameter" "node_ami" {
  name = "/aws/service/eks/optimized-ami/1.24/amazon-linux-2/recommended/image_id"
}