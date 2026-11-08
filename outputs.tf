output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this[0].id
}
output  "flow_log_output_format" {
  description = "The flow log output format"
  value       = local.vpc_flow_log_format
}
