resource "aws_route53_zone" "hzone" {
  name = var.domain

  tags = {
    environment = var.environment
    Name = "${var.environment}-${var.project}-pb-hzone"
  }
}

# resource "aws_route53_record" "root" {
#   zone_id = aws_route53_zone.hzone.id
#   name    = ""
#   type    = var.record.type
#   ttl     = 300
#   records = [var.record.records]
# }

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.hzone.id
  name    = var.record.name
  type    = var.record.type
  ttl     = 300
  records = [var.record.records]
}