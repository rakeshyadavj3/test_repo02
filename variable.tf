variable "cidr" {}
variable "envname" {
  type = string
  default = "cg-assignment"
}
variable "pubsubnet" {
  type = string
  default = "10.1.0.0/24"
}
variable "privatesubnet" {
  type = string
  default = "10.1.3.0/24"
}
