output "arn" {
  value       = aws_dynamodb_table.this.arn
  description = "ARN of the table"
}

output "id" {
  value       = aws_dynamodb_table.this.id
  description = "Name of the table"
}

output "replica_arn" {
  value       = aws_dynamodb_table.this.replica[*].arn
  description = "ARN of the replica"

}

output "replica_arns_by_region" {
  value       = { for replica in aws_dynamodb_table.this.replica : replica.region_name => replica.arn }
  description = "Replica ARNs keyed by Region."
}

output "replicas_by_region" {
  value       = { for replica in aws_dynamodb_table.this.replica : replica.region_name => replica }
  description = "Replica attributes keyed by Region."
}

output "replica_stream_arn" {
  value       = aws_dynamodb_table.this.replica[*].stream_arn
  description = "ARN of the replica Table Stream. Only available when stream_enabled = true."
}

output "replica_stream_arns_by_region" {
  value       = { for replica in aws_dynamodb_table.this.replica : replica.region_name => replica.stream_arn }
  description = "Replica stream ARNs keyed by Region."
}

output "replica_stream_label" {
  value       = aws_dynamodb_table.this.replica[*].stream_label
  description = "Timestamp, in ISO 8601 format, for the replica stream. Note that this timestamp is not a unique identifier for the stream on its own. However, the combination of AWS customer ID, table name and this field is guaranteed to be unique. It can be used for creating CloudWatch Alarms. Only available when stream_enabled = true."
}

output "replica_stream_labels_by_region" {
  value       = { for replica in aws_dynamodb_table.this.replica : replica.region_name => replica.stream_label }
  description = "Replica stream labels keyed by Region."
}

output "stream_arn" {
  value       = aws_dynamodb_table.this.stream_arn
  description = "ARN of the Table Stream. Only available when stream_enabled = true"
}

output "stream_label" {
  value       = aws_dynamodb_table.this.stream_label
  description = "Timestamp, in ISO 8601 format, for this stream. Note that this timestamp is not a unique identifier for the stream on its own. However, the combination of AWS customer ID, table name and this field is guaranteed to be unique. It can be used for creating CloudWatch Alarms. Only available when stream_enabled = true."
}

output "tags_all" {
  value       = aws_dynamodb_table.this.tags_all
  description = "Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}
