variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type = string
  default = "DevOps-Project-VPC"
}

variable "subnet_a_cidr_block" {
  description = "CIDR block for subnet A"
  type = string
  default = "10.0.1.0/24"
}

variable "subnet_a_az" {
  description = "Availability zone for subnet A"
  type = string
  default = "us-east-1a"
}

variable "subnet_a_public" {
  description = "Map public IP on launch for subnet A"
  type = bool
  default = true
}

variable "subnet_a_name" {
  description = "Name tag for subnet A"
  type = string
  default = "Subnet-A-Public"
}

variable "subnet_b_cidr_block" {
  description = "CIDR block for subnet B"
  type = string
  default = "10.0.2.0/24"
}

variable "subnet_b_az" {
  description = "Availability zone for subnet B"
  type = string
  default = "us-east-1b"
}

variable "subnet_b_public" {
  description = "Map public IP on launch for subnet B"
  type = bool
  default = false
}

variable "subnet_b_name" {
  description = "Name tag for subnet B"
  type = string
  default = "Subnet-B-Private"
}

variable "subnet_c_cidr_block" {
  description = "CIDR block for subnet C"
  type = string
  default = "10.0.3.0/24"
}

variable "subnet_c_az" {
  description = "Availability zone for subnet C"
  type = string
  default = "us-east-1e"
}

variable "subnet_c_public" {
  description = "Map public IP on launch for subnet C"
  type = bool
  default = false
}

variable "subnet_c_name" {
  description = "Name tag for subnet C"
  type = string
  default = "Subnet-C-Private"
}

variable "public_sb_name" {
  description = "Name of the public subnet"
  type = string
  default = "subnet_a"
}

variable "route_tb_name" {
  description = "Name of the route table"
  type = string
  default = "DevOps-project-RT"
}

variable "internetgw_name" {
  description = "Name of the internet gateway of the VPC"
  type = string
  default = "devops-project-igw"
}

variable "nat_gw_name" {
  description = "The name of the NAT gateway"
  type = string
  default = "DevOps-NAT-GW"
}

variable "byoip_pool_name" {
  description = "Name of the BOYIP pool"
  type = string
  default = "amazon"
}
