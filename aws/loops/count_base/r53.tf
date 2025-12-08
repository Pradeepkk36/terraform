resource "aws_route53_record" "route53_demo" {
  count = var.instance_count
  zone_id = var.host_zone_id
  name    = "instance-${count.index}.${var.domain_name}" #interpolation
  type    = "A"
  ttl     = 1
  records = [aws_instance.count_base_demo[count.index].private_ip] #list type
  allow_overwrite = true
}

resource "aws_route53_record" "second_instance" {
  zone_id = var.host_zone_id
  name    = "${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.count_base_demo[1].public_ip] #list type
  allow_overwrite = true
}