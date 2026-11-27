module "table" {
  source = "../resources/table"

  hash_key                    = var.table.hash_key
  name                        = var.table.name
  attribute                   = var.table.attribute
  billing_mode                = lookup(var.table, "billing_mode", null)
  deletion_protection_enabled = lookup(var.table, "deletion_protection_enabled", null)
  region                      = lookup(var.table, "region", null)
  global_secondary_index      = lookup(var.table, "global_secondary_index", null)
  global_table_witness        = lookup(var.table, "global_table_witness", null)
  import_table                = lookup(var.table, "import_table", null)
  local_secondary_index       = lookup(var.table, "local_secondary_index", null)
  on_demand_throughput        = lookup(var.table, "on_demand_throughput", null)
  point_in_time_recovery      = lookup(var.table, "point_in_time_recovery", null)
  range_key                   = lookup(var.table, "range_key", null)
  read_capacity               = lookup(var.table, "read_capacity", null)
  replica                     = lookup(var.table, "replica", null)
  restore_backup_arn          = lookup(var.table, "restore_backup_arn", null)
  restore_date_time           = lookup(var.table, "restore_date_time", null)
  restore_source_name         = lookup(var.table, "restore_source_name", null)
  restore_source_table_arn    = lookup(var.table, "restore_source_table_arn", null)
  restore_to_latest_time      = lookup(var.table, "restore_to_latest_time", null)
  server_side_encryption      = lookup(var.table, "server_side_encryption", null)
  stream_enabled              = lookup(var.table, "stream_enabled", null)
  stream_view_type            = lookup(var.table, "stream_view_type", null)
  table_class                 = lookup(var.table, "table_class", null)
  ttl                         = lookup(var.table, "ttl", null)
  warm_throughput             = lookup(var.table, "warm_throughput", null)
  write_capacity              = lookup(var.table, "write_capacity", null)
  timeouts                    = lookup(var.table, "timeouts", null)

  tags = lookup(var.table, "tags", null)
}

module "global_secondary_index" {
  source = "../resources/global_secondary_index"

  for_each = var.global_secondary_index_map

  table_name = module.table.id
  region     = each.value.region != null ? each.value.region : var.table.region

  index_name             = each.value.index_name
  key_schema             = each.value.key_schema
  on_demand_throughput   = lookup(each.value, "on_demand_throughput", null)
  projection             = lookup(each.value, "projection", null)
  provisioned_throughput = lookup(each.value, "provisioned_throughput", null)
  warm_throughput        = lookup(each.value, "warm_throughput", null)
  timeouts               = lookup(each.value, "timeouts", null)
}

module "contributor_insights" {
  source = "../resources/contributor_insights"

  for_each = var.contributor_insights_map

  table_name = module.table.id
  index_name = each.value.index_name != null ? each.value.index_name : each.value.global_secondary_index_custom_name != null ? module.global_secondary_index[each.value.global_secondary_index_custom_name].index_name : null
  region     = each.value.region != null ? each.value.region : each.value.index_name == null && each.value.global_secondary_index_custom_name != null ? module.global_secondary_index[each.value.global_secondary_index_custom_name].region : var.table.region

  mode     = lookup(each.value, "mode", null)
  timeouts = lookup(each.value, "timeouts", null)
}

module "kinesis_streaming_destination" {
  source = "../resources/kinesis_streaming_destination"

  count = var.kinesis_streaming_destination != null ? 1 : 0

  table_name = module.table.id
  region     = var.kinesis_streaming_destination.region != null ? var.kinesis_streaming_destination.region : var.table.region

  stream_arn                               = var.kinesis_streaming_destination.stream_arn
  approximate_creation_date_time_precision = lookup(var.kinesis_streaming_destination, "approximate_creation_date_time_precision", null)
}

module "table_resource_policy" {
  source = "../resources/resource_policy"

  count = var.table_resource_policy != null ? 1 : 0

  resource_arn = module.table.arn

  policy                              = var.table_resource_policy.policy
  region                              = var.table_resource_policy.region != null ? var.table_resource_policy.region : var.table.region
  confirm_remove_self_resource_access = lookup(var.table_resource_policy, "confirm_remove_self_resource_access", null)
}

module "stream_resource_policy" {
  source = "../resources/resource_policy"

  count = var.stream_resource_policy != null ? 1 : 0

  resource_arn = module.table.stream_arn

  policy                              = var.stream_resource_policy.policy
  region                              = var.stream_resource_policy.region != null ? var.stream_resource_policy.region : var.table.region
  confirm_remove_self_resource_access = lookup(var.stream_resource_policy, "confirm_remove_self_resource_access", null)
}

module "replica_resource_policy" {
  source = "../resources/resource_policy"

  for_each = var.replica_resource_policy_map

  resource_arn = module.table.replica_arns_by_region[each.key]
  region       = each.key

  policy                              = each.value.policy
  confirm_remove_self_resource_access = lookup(each.value, "confirm_remove_self_resource_access", null)
}
