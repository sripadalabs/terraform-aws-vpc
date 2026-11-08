# If both ipv4_ipam_pool_id and ipv4_netmask_length are provided, 
# the VPC will be created with the specified IPAM pool and netmask length. 
# If only one of these values is provided, an error will occur. If neither value is provided, 
# the VPC will be created with the default CIDR block specified in vpc_cidr.

locals{
    use_ipam = var.ipv4_ipam_pool_id != "" && var.ipv4_netmask_length != 0
    vpc_cidr = local.use_ipam ? null : var.vpc_cidr
    vpc_flow_log_format = <<EOT
        $$${version} $$${account-id} $$${interface-id} $$${srcaddr} $$${dstaddr} $$${srcport} $$${dstport} $$${protocol} $$${packets} $$${bytes} $$${start} $$${end} $$${action} $$${log-status} $$${region} $$${az-id} $$${subnet-id} $$${instance-id} $$${tcp-flags} $$${pkt-srcaddr} $$${pkt-dstaddr} $$${pkt-src-aws-service} $$${pkt-dst-aws-service} $$${flow-direction} $$${traffic-path}
        EOT
}