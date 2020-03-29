# ------------------------------------------------------------------------------
# MODULE PARAMETERS
# These variables are expected to be passed in by the operator
# ------------------------------------------------------------------------------

variable "aws_region" {
  description = "The AWS region in which all resources will be created"
  type        = string
}

variable "aws_account_id" {
  description = "The ID of the AWS Account in which to create resources."
  type        = string
}

# ------------------------------------------------------------------------------
variable "certificate_name" {
  description = "Name of the ACM certificate"
  type        = string
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
