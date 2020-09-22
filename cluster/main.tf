

module "eks" {
  source     = "github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v10.0.0"
  create_eks = var.create

  cluster_name    = var.id
  cluster_version = "1.16"

  subnets = module.vpc.public_subnets
  vpc_id  = module.vpc.vpc_id

  //  cluster_security_group_id            = var.security_group_id
  //  worker_additional_security_group_ids = var.worker_additional_security_group_ids

  worker_groups = [
    {
      name                 = "workers"
      instance_type        = var.worker_instance_type
      asg_desired_capacity = var.num_workers
      asg_min_size         = var.cluster_autoscale_min_workers
      asg_max_size         = var.cluster_autoscale_max_workers
      tags = concat([{
        key                 = "Name"
        value               = "${var.id}-workers-1"
        propagate_at_launch = true
        }
      ])
    }
  ]

  tags = var.tags
}


