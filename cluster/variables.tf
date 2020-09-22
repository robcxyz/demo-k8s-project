variable "create" {
  description = "Bool to create"
  type        = bool
  default     = true
}

variable "id" {
  description = "The id of the resources"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}

#####
# K8S
#####
variable "worker_instance_type" {
  description = "The instance class for workers"
  type        = string
  default     = "m5.large"
}

//variable "cluster_name" {
//  description = "Name of the k8s cluster"
//  type        = string
//}

//variable "k8s_version" {
//  description = "Version of k8s to use - override to use a version other than `latest`"
//  type        = string
//  default     = null
//}

variable "num_workers" {
  description = "Number of workers for worker pool"
  type        = number
  default     = 1
}

variable "cluster_autoscale" {
  description = "Do you want the cluster's worker pool to autoscale?"
  type        = bool
  default     = false
}

variable "cluster_autoscale_min_workers" {
  description = "Minimum number of workers in worker pool"
  type        = number
  default     = 1
}

variable "cluster_autoscale_max_workers" {
  description = "Maximum number of workers in worker pool"
  type        = number
  default     = 4
}

######
# VPC
######
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = ""
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = []
}

variable "num_azs" {
  description = "The number of AZs to deploy into"
  type        = number
  default     = 3
}

variable "cidr" {
  description = "The cidr range for network"
  type        = string
  default     = "10.0.0.0/16"
}

