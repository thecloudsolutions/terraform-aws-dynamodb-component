output "arn" {
  value       = aws_dynamodb_global_secondary_index.this.arn
  description = "ARN of the global secondary index."
}

output "index_name" {
  value       = aws_dynamodb_global_secondary_index.this.index_name
  description = "Name of the global secondary index."
}

output "region" {
  value       = aws_dynamodb_global_secondary_index.this.region
  description = "Region where the resource is managed."
}
