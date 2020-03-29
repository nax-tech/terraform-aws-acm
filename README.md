# Terraform AWS ACM module
This module is simple and straight forward. Use it to request your domain name certificates. Pay close attention to the variables and the subdomain levels that you include in your request.

When using the module, there are two variables that can make or break you. One is for the Route5 DNS entry and one is for the specific domain levels you want, these variables should have a root domain that matches,  but can differ in their subdomain mappings. Example below for a wildcard single level certificate.

```hcl
hosted_name = "charge.io" # maps to your Route53 DNS entry name
domain_name = "*.charge.io" # requesting a wildcard certificate
```

... all validation will happen through DNS. I can't imagine you'd want to use email for this...

# Usage
```hcl
module "aws_acm" {
	source = "git@github.com:charge-tech/terraform-aws-acm.git?ref=v0.0.1"

	certificate_name = "ChargeIO"
	hosted_name = "charge.io"
	domain_name = "*.charge.io"
}
```
