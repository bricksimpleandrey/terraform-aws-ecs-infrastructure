variable "env_name" {
	default = "dev"
	description = "The environment name"
}

variable "s3prefix" {
	default = "brick-new"
	description = "The s3 prefix needed for storing remote tf state files"
}

variable "region" {
	default = "us-east-1"
	description = "The region for the aws VPC"
}

variable "azs" {
	default = "us-east-1a,us-east-1b,us-east-1c"
	description = "List of availability zones"
}

# This is the root ssh key used for the ec2 instance
variable "ssh_key_name" {
	default = "root-ssh-key-us-east-1"
	description = "The name of the preloaded root ssh key used to access AWS resources."
}

variable "dockerhub_email" {
	description = "Your dockerhub account email"
}

# http://docs.aws.amazon.com/AmazonECS/latest/developerguide/private-auth.html
variable "dockerhub_token" {
	description = "The token from your docker login command"
}

variable "cidr" {
	default = "10.0.0.0/16"
}

variable "private_subnets" {
	default = "10.0.101.0/24,10.0.102.0/24,10.0.103.0/24"
}

variable "public_subnets" {
	default = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
}

variable "amazon_amis" {
	description = "Amazon Linux AMIs"
	type = "map"
	default = {
		us-west-2 = "ami-5ec1673e"
		us-east-2 = "ami-58277d3d"
		us-east-1 = "ami-0080dc2d6cbfc4c39"
	}
}

// Update these AMI IDs - http://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_container_instance.html
variable "amazon_ecs_amis" {
	type = "map"
	default = {
		"us-west-1" = "ami-4a2c192a"
		"us-west-2" = "ami-1d668865"
		"us-east-2" = "ami-43d0f626"
		"us-east-1" = "ami-09bee01cc997a78a6"
	}
}

variable "ecs_instance_type" {
	description = "The AWS ECS instance type"
	default = "t2.micro"
}

variable "asg_min" {
	description = "Min numbers of EC2s in ASG"
	default = "1"
}

variable "asg_max" {
	description = "Max numbers of EC2s in ASG"
	default = "1"
}

variable "asg_desired" {
	description = "Desired numbers of EC2s in ASG"
	default = "1"
}
