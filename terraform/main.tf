terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.14"
}

provider "aws" {
  region  = "us-east-1"
}


module "vpc" {
  source = "./vpc_configuration"
  vpc_cidr_block = "10.0.0.0/16"
  subnet_cidr_blocks  = ["10.0.1.0/24"]
  availability_zones = ["us-east1a"]
}

module "ssm_endpoints" {
  source = "./ssm"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_id
  ssm_sg_id = module.vpc.ssm_sg_id
  aws_region = "us-east-1"
}

module "ssm_iam" {
  source = "./iam/iam_role"
}

module "ssm_instance_profile" {
  source = "./iam/iam_instance_profile"
  iam_role = module.ssm_iam.iam_role
}

module "ami" {
  source = "./autoscaling/ami"
}


module "launch_template" {
  source = "./autoscaling/launch_templates"
  instance_sg_id = module.vpc.instance_sg_id
  iam_instance_profile = module.ssm_instance_profile.iam_instance_profile
  vpc_id = module.vpc.vpc_id
  ami_id = module.ami.ami_id

}

module "autoscaling" {
  source = "./autoscaling/asg"

  launch_template_id = module.launch_template.launch_template_id
  target_group_arn = module.launch_template.my_tg
  private_subnet_id = module.vpc.private_subnet_id
  public_subnet_id = module.vpc.public_subnet_id
}

module "scaleout_policy" {
  source = "./autoscaling/scaleout_policy"
  autoscaling_group_name = module.autoscaling.autoscaling_group_name
}

module "scalein_policy" {
  source = "./autoscaling/scalein_policy"
  autoscaling_group_name = module.autoscaling.autoscaling_group_name

}

module "aws_sns_topic" {
  source = "./sns"
}
module "cloudwatch_monitoring" {
  source = "./cloudwatch"
  aws_sns_topic = module.aws_sns_topic.sns_topic_arn
  autoscaling_group_name = module.autoscaling.autoscaling_group_name
}

module "cloudwatch_scaleout_policy" {
  source = "./autoscaling/cloudwatch_scalein"
  scalin_policy_arn = module.scaleout_policy.scale_out_arn
  autoscaling_group_name = module.autoscaling.autoscaling_group_name
}

module "cloudwatch_scalein_policy" {
  source = "./autoscaling/cloudwatch_scaleout"
  scaleout_policy_arn = module.scalein_policy.scale_in_arn
  autoscaling_group_name = module.autoscaling.autoscaling_group_name
}


module "load_balancer" {
  source = "./load_balancer/application_load_balancer"
  lb_sg_id = module.vpc.lb_sg_id
  public_subnet_id = module.vpc.public_subnet_id
}

module "certificate" {
  source = "./load_balancer/certificate"
}

module "listener" {
  source = "./load_balancer/listener"
  my_alb_arn = module.load_balancer.alb_arn
  my_cert_arn = module.certificate.cert_arn
  target_group_arn = module.launch_template.my_tg
}
  

module "route53" {
  source = "./route53"
  vpc_id = module.vpc.vpc_id
  alb_dns_name = module.load_balancer.alb_dns_name
}
