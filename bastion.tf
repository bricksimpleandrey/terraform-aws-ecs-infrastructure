# Basion EC2 Instance

# EC2

resource "aws_instance" "bastion" {
  ami = "${lookup(var.amazon_amis, var.region)}"
  instance_type = "t2.micro"
  key_name = "${var.ssh_key_name}"
  vpc_security_group_ids = [
    "${aws_security_group.bastion.id}"
  ]
  subnet_id                   = "${element(module.vpc.public_subnets, 0)}"
  associate_public_ip_address = true
  source_dest_check           = false
  iam_instance_profile        = "${aws_iam_instance_profile.bastion_profile.name}"

  tags = {
    Name = "${var.env_name}-bastion"
    ManagedBy = "Terraform"
  }
}

# SG

resource "aws_security_group" "bastion" {
  name = "bastion"
  description = "Allow access from allowed_network to SSH/Consul, and NAT internal traffic"
  vpc_id = "${module.vpc.vpc_id}"

  # SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self = false
  }

  # Can access anything on the internet via http
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_name}-bastion-external"
    ManagedBy = "Terraform"

  }
}

# IAM

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${var.env_name}-${var.region}-bastion-profile"
  role = "${aws_iam_role.bastion_iam_role.name}"
}

resource "aws_iam_role" "bastion_iam_role" {
  name = "${var.env_name}-${var.region}-bastion-role"
  path = "/"
  assume_role_policy = "${data.aws_iam_policy_document.assume-role-policy.json}"
}
