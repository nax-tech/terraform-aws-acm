output "acm_certificate_arn" {
  description = "ARN of ACM certificate"
  value       = "${aws_acm_certificate.certificate.arn}"
}

output "acm_certificate_dns_validation_record" {
  description = "DNS record used for ACM validation"
  value       = [for record in aws_route53_record.certificate_validation : record.name]
}
