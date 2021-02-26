locals {
  zoneName = "${var.stage}.${var.zone}"
  domainName = "test.${local.zoneName}"
}

variable "stage" {
}

variable "zone" {
  default = "acme.com"
}

variable "region" {
  default = "eu-central-1"
}
