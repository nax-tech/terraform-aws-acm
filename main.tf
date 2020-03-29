locals {
	validation = "DNS"
}

resource "aws_acm_certificate" "certificate" {
  domain_name       = var.domain_name
  validation_method = local.validation

	tags = {
    Name = "${var.certificate_name}"
	}
}

resource "aws_route53_record" "certificate_validation" {
  name    = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name
	records = ["${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value}"]
  type    = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.zone.id
	ttl     = 60
}

resource "aws_acm_certificate_validation" "certificate" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = ["${aws_route53_record.certificate_validation.fqdn}"]
}
