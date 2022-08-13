variable "cidr_vpc" {
  default = "10.6.0.0/16"
  description = "cidr block for vpc"
}

variable "name_vpc" {
  default  = "TEST"
}

variable "aws_subnet_private_1" {
  default = "10.6.1.0/24"
  description = "cidr block for subnet private 1"
}

variable "aws_subnet_private_2" {
  default = "10.6.2.0/24"
  description = "cidr block for subnet private 2"
}

variable "aws_subnet_public_1" {
  default = "10.6.3.0/24"
  description = "cidr block for subnet public 1"
}

variable "aws_subnet_public_2" {
  default = "10.6.4.0/24"
  description = "cidr block for subnet public 1"
}

variable "enable_nat_gateway" {
  type = bool
  default = false
}