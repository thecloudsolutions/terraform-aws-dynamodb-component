module "dynamodb" {
  source = "./module"

  for_each = var.dynamodb_map

  table                         = each.value.table
  global_secondary_index_map    = lookup(each.value, "global_secondary_index_map", null)
  contributor_insights_map      = lookup(each.value, "contributor_insights_map", null)
  kinesis_streaming_destination = lookup(each.value, "kinesis_streaming_destination", null)
  table_resource_policy         = lookup(each.value, "table_resource_policy", null)
  stream_resource_policy        = lookup(each.value, "stream_resource_policy", null)
  replica_resource_policy_map   = lookup(each.value, "replica_resource_policy_map", null)
}
