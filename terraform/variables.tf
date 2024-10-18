
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}
variable "acru"{
	default="flexi2914"
}
variable "pwd"{
	default="zO19Z50Z06Kg2tmIBL0+sSGXlRtXdWvf0kJFQEyh7v+ACRCQT5kc"
}
variable "resource_group_name" {
  default = "flexi"
}

variable "location" {
  default = "East US"
}

variable "frontend_port" {
  default = 3000
}

variable "backend_port" {
  default = 5000
}
