
locals {
  tgws = flatten([
    for tgw_name, tgw in var.tgws : [
      for rtb in tgw.route_tables : [
        merge({ rtb_name : rtb }, { tgw_name : tgw_name })
      ]
    ]
  ])
}


# CREATE TGW
resource "aws_ec2_transit_gateway" "this" {
  for_each                        = var.tgws
  description                     = lookup(each.value, "description", null)
  vpn_ecmp_support                = lookup(each.value, "vpn_ecmp_support", "enable")
  default_route_table_association = lookup(each.value, "default_route_table_association", "disable")
  default_route_table_propagation = lookup(each.value, "default_route_table_propagation", "disable")
  dns_support                     = lookup(each.value, "dns_support", "enable")
  auto_accept_shared_attachments  = lookup(each.value, "auto_accept_shared_attachments", "disable")

  tags = merge(var.tags, { Name = each.key })
}


# CREATE TGW ROUTE TABLES
resource "aws_ec2_transit_gateway_route_table" "this" {
  for_each           = { for rtb in local.tgws : rtb.rtb_name => rtb.tgw_name }
  transit_gateway_id = aws_ec2_transit_gateway.this[each.value].id

  tags = merge(var.tags, { Name = each.key })
}
