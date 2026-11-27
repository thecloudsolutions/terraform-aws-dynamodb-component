output "dynamodb_table_arns" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].table_arn }
  description = "ARN of the table"
}

output "dynamodb_table_ids" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].table_id }
  description = "Name of the table"
}

output "dynamodb_table_tags_all" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].table_tags_all }
  description = "Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "dynamodb_table_stream_arns" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].table_stream_arn }
  description = "Table stream ARNs keyed by table."
}

output "dynamodb_table_stream_labels" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].table_stream_label }
  description = "Table stream labels keyed by table."
}

output "dynamodb_table_replica_arns" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].table_replica_arns }
  description = "Replica ARNs keyed by table and Region."
}

output "dynamodb_table_replicas" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].table_replicas }
  description = "Replica attributes keyed by table and Region."
}

output "dynamodb_table_replica_stream_arns" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].table_replica_stream_arns }
  description = "Replica stream ARNs keyed by table and Region."
}

output "dynamodb_table_replica_stream_labels" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].table_replica_stream_labels }
  description = "Replica stream labels keyed by table and Region."
}

output "dynamodb_global_secondary_index_arns" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].global_secondary_index_arns }
  description = "Standalone global secondary index ARNs keyed by table and index."
}

output "dynamodb_global_secondary_index_names" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].global_secondary_index_names }
  description = "Standalone global secondary index names keyed by table and index."
}

output "dynamodb_global_secondary_index_regions" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].global_secondary_index_regions }
  description = "Standalone global secondary index Regions keyed by table and index."
}

output "dynamodb_contributor_insights_ids" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].contributor_insights_ids }
  description = "Contributor Insights identifiers keyed by table and configuration."
}

output "dynamodb_kinesis_streaming_destination_ids" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].kinesis_streaming_destination_id }
  description = "Kinesis streaming destination identifiers keyed by table."
}

output "dynamodb_table_resource_policy_revision_ids" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].table_resource_policy_revision_id }
  description = "Table policy revision IDs keyed by table."
}

output "dynamodb_stream_resource_policy_revision_ids" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].stream_resource_policy_revision_id }
  description = "Stream policy revision IDs keyed by table."
}

output "dynamodb_replica_resource_policy_revision_ids" {
  value       = { for table in keys(module.dynamodb) : table => module.dynamodb[table].replica_resource_policy_revision_ids }
  description = "Replica policy revision IDs keyed by table and Region."
}
