locals {
  validation = "DNS"
}

provider "aws" {
  # The AWS region in which all resources will be created
  region = var.aws_region

  # Provider version 2.X series is the latest, but has breaking changes with 1.X series.
  version = "~> 2.6"

  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = [var.aws_account_id]
}

# ---------------------------------------------------------------------------------------------------------------------
# CONFIGURE REMOTE STATE STORAGE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}

  # Only allow this Terraform version. Note that if you upgrade to a newer version, Terraform won't allow you to use an
  # older version, so when you upgrade, you should upgrade everyone on your team and your CI servers all at once.
  required_version = "= 0.12.17"
}

resource "aws_acm_certificate" "certificate" {
  domain_name       = var.domain_name
  validation_method = local.validation

  tags = {
    Name = "${var.certificate_name}"
  }
}

resource "aws_route53_record" "certificate_validation" {
  # name    = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name
  # records = ["${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value}"]
  # type    = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type
  # zone_id = data.aws_route53_zone.zone.id
  # ttl     = 60

  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.example.zone_id
}

# resource "aws_acm_certificate_validation" "certificate" {
#   certificate_arn         = aws_acm_certificate.certificate.arn
#   validation_record_fqdns = ["${aws_route53_record.certificate_validation.fqdn}"]
# }

resource "aws_acm_certificate_validation" "certificate" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate : record.fqdn]
}
