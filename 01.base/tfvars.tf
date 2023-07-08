variable "project" {
  type = string
}
variable "region" {
  type = string
}
variable "environment" {
  type = string
}

# EC2 関連
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}