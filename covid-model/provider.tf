variable "cluster_id" {
  description = "The ID of the eks cluster"
  type = string
}

variable "region" {
  description = "AWS region"
  type = string
  default = "us-east-1"
}

data "aws_eks_cluster_auth" "this" {
  name = var.cluster_id
}

data "aws_eks_cluster" "this" {
  name = var.cluster_id
}

provider "aws" {
  region = var.region
  skip_get_ec2_platforms     = true
  skip_metadata_api_check    = true
  skip_region_validation     = true
  skip_requesting_account_id = true
}

provider "helm" {
  version = "=1.1.1"
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.this.token
    load_config_file       = false
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.this.token
  load_config_file       = false
}