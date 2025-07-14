variable "region" {
  default = "us-west-2"
}

variable "vpc_name" {
  default = "log-a-rythm-vpc"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet1_cidr" {
  default = "10.0.2.0/24"
}

variable "private_subnet2_cidr" {
  default = "10.0.3.0/24"
}

variable "availability_zone" {
  default = "us-west-2a"
}