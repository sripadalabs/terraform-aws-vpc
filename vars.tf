variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
  default     = "acimate-managed-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = ""
}

variable "ipv4_ipam_pool_id" {
  description = "The ID of the IPv4 IPAM pool to use for the VPC."
  type        = string
  default     = ""
}

variable "ipv4_netmask_length" {
  description = "The netmask length of the IPv4 CIDR to allocate from the IPAM pool."
  type        = number
  default     = 0
}

variable "create_vpc" {
  description = "Whether to create a new VPC or use an existing one."
  type        = bool
  default     = true
}
variable "enable_dns_hostnames"{
    description = "A boolean flag to enable/disable DNS hostnames in the VPC."
    type        = bool
    default     = true
}

variable "enable_dns_support"{
    description = "A boolean flag to enable/disable DNS support in the VPC."
    type        = bool
    default     = true
}

variable "network_address_usage_metrics"{
    description = "A boolean flag to enable/disable network address usage metrics in the VPC."
    type        = bool
    default     = true
}

variable "tags" {
  description = "A map of tags to assign to the VPC."
  type        = map(string)
  default     = {}
}

variable "vpc_flow_logs_bucket_arn" {
  description = "Existing S3 bucket ARN for flow logs. If provided, no new bucket will be created."
  type        = string
  default     = ""
}

variable "flow_logs_bucket_name" {
  description = "Name of the S3 bucket to create if no ARN is provided."
  type        = string
  default     = "my-vpc-flow-logs"
}
