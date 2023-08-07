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
variable "template_image_id" {
  type = string
}
variable "instance_type" {
  type = string
}

# Route53 関連
variable "domain_name" {
  type = string
}
variable "host_zone_id" {
  type = string
}