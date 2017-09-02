# Terraform AWS ECS Infrastructure

The foundation of your infrastructure using Amazon Elastic Container Service

This terraform script will create a VPC + Bastion Instance + ECS Cluster

## Instructions

This should only really be called with Jenkins but you can call it locally by creating a variables.tfvars file with contents like:

```
env_name = "dev"
region = "us-west-2"
"azs" = "us-west-2a,us-west-2b,us-west-2c"
"ssh_key_name" = "root-ssh-key-us-west-2"
"cidr" = "10.0.0.0/16"
"private_subnets" = "10.0.101.0/24,10.0.102.0/24,10.0.103.0/24"
"public_subnets" = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
"ecs_instance_type" = "t2.medium"
"asg_min" = "1"
"asg_max" = "1"
"asg_desired" = "1"
"dockerhub_email" = ""
"dockerhub_token" = ""
```

Then you can call `./tf-apply.sh variables.tfvars` to provision the stack

### How to hop to an ECS Agent Instance

First add an entry in your `.ssh/config` file that has your bastion IP and tell it to forward your SSH Agent.

```
Host bastion.ip.address.here
  ForwardAgent yes
```

Then head over to you [EC2 Dashboard](https://us-west-2.console.aws.amazon.com/ec2/v2/home?region=us-west-2#Instances:sort=instanceId) and select on of the *-ecs-asg instances to copy the private IP address.

SSH to bastion `ssh ec2-user@bastion.ip.address.here` and then once on the server, SSH to the private ip of the ECS EC2 Instance `ssh ec2-user@ecs.instance.ip.here`

Then you can run `docker ps` once there to make sure you see the ecs-agent running.
