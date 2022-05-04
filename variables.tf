variable "cluster_name" {
  type = string
}

variable "neptune_version" {
  type    = string
  default = "1.1.1.0.R1"
}

variable "number_of_instances" {
  type    = number
  default = 1
}

variable "instance_type" {
  type    = string
  default = "db.r5.large"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "vpc_name" {
  default = ""
}

variable "subnet_cidr" {
  type    = list(any)
  default = [""]
}