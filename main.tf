resource "aws_vpc" "this" {
  count = var.create_vpc ? 1 : 0
  cidr_block           = local.use_ipam ? null : var.vpc_cidr
  ipv4_ipam_pool_id     = local.use_ipam ? var.ipv4_ipam_pool_id : null
  ipv4_netmask_length   = local.use_ipam ? var.ipv4_netmask_length : null
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = merge(var.tags,
    {
      "managed-vpc" = true
    }
  )
}

