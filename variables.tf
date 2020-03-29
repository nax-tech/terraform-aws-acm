variable "certificate_name" {
  description = "Name of the ACM certificate"
  type        = "string"
}

variable "domain_name" {
	description = "Primary domain name to be used for the certificate, can include wildcard here"
  type        = string
}

variable "hosted_name" {
	description = "AWS Route53 domain name entry, your exact domain name"
  type        = string
}

variable "private_zone" {
	description = "If zone is private or public facing"
	type 				= bool
	default 		= false
}
