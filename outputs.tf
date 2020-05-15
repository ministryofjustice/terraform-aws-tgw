output "tgws" {
  value = aws_ec2_transit_gateway.this
}

output "tgw_rtbs" {
  value = aws_ec2_transit_gateway_route_table.this
}
