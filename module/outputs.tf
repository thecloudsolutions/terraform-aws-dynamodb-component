output "table_arn" {
  value       = module.table.arn
  description = "ARN of the table"
}

output "table_id" {
  value       = module.table.id
  description = "Name of the table"
}

output "table_tags_all" {
  value       = module.table.tags_all
  description = "Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "table_stream_arn" {
  value       = module.table.stream_arn
  description = "ARN of the table stream."
}

output "table_stream_label" {
  value       = module.table.stream_label
  description = "Label of the table stream."
}

output "table_replica_arns" {
  value       = module.table.replica_arns_by_region
  description = "Replica ARNs keyed by Region."
}

output "table_replicas" {
  value       = module.table.replicas_by_region
  description = "Replica attributes keyed by Region."
}

output "table_replica_stream_arns" {
  value       = module.table.replica_stream_arns_by_region
  description = "Replica stream ARNs keyed by Region."
}

output "table_replica_stream_labels" {
  value       = module.table.replica_stream_labels_by_region
  description = "Replica stream labels keyed by Region."
}

output "global_secondary_index_arns" {
  value       = { for index in keys(module.global_secondary_index) : index => module.global_secondary_index[index].arn }
  description = "Standalone global secondary index ARNs keyed by index."
}

output "global_secondary_index_names" {
  value       = { for index in keys(module.global_secondary_index) : index => module.global_secondary_index[index].index_name }
  description = "Standalone global secondary index names keyed by index."
}

output "global_secondary_index_regions" {
  value       = { for index in keys(module.global_secondary_index) : index => module.global_secondary_index[index].region }
  description = "Standalone global secondary index Regions keyed by index."
}

output "contributor_insights_ids" {
  value       = { for insights in keys(module.contributor_insights) : insights => module.contributor_insights[insights].id }
  description = "Contributor Insights identifiers keyed by configuration."
}

output "kinesis_streaming_destination_id" {
  value       = var.kinesis_streaming_destination != null ? module.kinesis_streaming_destination[0].id : null
  description = "Identifier of the table's Kinesis streaming destination."
}

output "table_resource_policy_revision_id" {
  value       = var.table_resource_policy != null ? module.table_resource_policy[0].revision_id : null
  description = "Revision ID of the table resource policy."
}

output "stream_resource_policy_revision_id" {
  value       = var.stream_resource_policy != null ? module.stream_resource_policy[0].revision_id : null
  description = "Revision ID of the stream resource policy."
}

output "replica_resource_policy_revision_ids" {
  value       = { for region in keys(module.replica_resource_policy) : region => module.replica_resource_policy[region].revision_id }
  description = "Replica resource policy revision IDs keyed by Region."
}
