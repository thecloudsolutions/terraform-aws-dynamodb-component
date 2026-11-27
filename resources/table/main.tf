resource "aws_dynamodb_table" "this" {
  hash_key                    = var.hash_key
  name                        = var.name
  billing_mode                = var.billing_mode
  deletion_protection_enabled = var.deletion_protection_enabled
  region                      = var.region
  range_key                   = var.range_key
  read_capacity               = var.read_capacity
  restore_backup_arn          = var.restore_backup_arn
  restore_date_time           = var.restore_date_time
  restore_source_name         = var.restore_source_name
  restore_source_table_arn    = var.restore_source_table_arn
  restore_to_latest_time      = var.restore_to_latest_time
  stream_enabled              = var.stream_enabled
  stream_view_type            = var.stream_view_type
  table_class                 = var.table_class
  write_capacity              = var.write_capacity

  dynamic "attribute" {
    for_each = var.attribute
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_index
    content {
      hash_key           = lookup(global_secondary_index.value, "hash_key", null)
      name               = global_secondary_index.value.name
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
      projection_type    = global_secondary_index.value.projection_type
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)

      dynamic "key_schema" {
        for_each = lookup(global_secondary_index.value, "key_schema", [])
        content {
          attribute_name = key_schema.value.attribute_name
          key_type       = key_schema.value.key_type
        }
      }

      dynamic "on_demand_throughput" {
        for_each = lookup(global_secondary_index.value, "on_demand_throughput", null) != null ? [global_secondary_index.value.on_demand_throughput] : []
        content {
          max_read_request_units  = lookup(on_demand_throughput.value, "max_read_request_units", null)
          max_write_request_units = lookup(on_demand_throughput.value, "max_write_request_units", null)
        }
      }

      dynamic "warm_throughput" {
        for_each = lookup(global_secondary_index.value, "warm_throughput", null) != null ? [global_secondary_index.value.warm_throughput] : []
        content {
          read_units_per_second  = lookup(warm_throughput.value, "read_units_per_second", null)
          write_units_per_second = lookup(warm_throughput.value, "write_units_per_second", null)
        }
      }
    }
  }

  dynamic "global_table_witness" {
    for_each = var.global_table_witness != null ? [var.global_table_witness] : []
    content {
      region_name = lookup(global_table_witness.value, "region_name", null)
    }
  }

  dynamic "import_table" {
    for_each = var.import_table != null ? [var.import_table] : []
    content {
      input_compression_type = lookup(import_table.value, "input_compression_type", null)
      input_format           = import_table.value.input_format

      dynamic "input_format_options" {
        for_each = lookup(import_table.value, "input_format_options", null) != null ? [import_table.value.input_format_options] : []
        content {
          dynamic "csv" {
            for_each = lookup(input_format_options.value, "csv", null) != null ? [input_format_options.value.csv] : []
            content {
              delimiter   = lookup(csv.value, "delimiter", null)
              header_list = lookup(csv.value, "header_list", null)
            }
          }
        }
      }

      dynamic "s3_bucket_source" {
        for_each = [import_table.value.s3_bucket_source]
        content {
          bucket       = s3_bucket_source.value.bucket
          bucket_owner = lookup(s3_bucket_source.value, "bucket_owner", null)
          key_prefix   = lookup(s3_bucket_source.value, "key_prefix", null)
        }
      }
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_index
    content {
      name               = local_secondary_index.value.name
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
      projection_type    = local_secondary_index.value.projection_type
      range_key          = lookup(local_secondary_index.value, "range_key", null)
    }
  }

  dynamic "point_in_time_recovery" {
    for_each = var.point_in_time_recovery != null ? [var.point_in_time_recovery] : []
    content {
      enabled                 = point_in_time_recovery.value.enabled
      recovery_period_in_days = lookup(point_in_time_recovery.value, "recovery_period_in_days", null)
    }
  }

  dynamic "on_demand_throughput" {
    for_each = var.on_demand_throughput != null ? [var.on_demand_throughput] : []
    content {
      max_read_request_units  = lookup(on_demand_throughput.value, "max_read_request_units", null)
      max_write_request_units = lookup(on_demand_throughput.value, "max_write_request_units", null)
    }
  }

  dynamic "replica" {
    for_each = var.replica
    content {
      consistency_mode            = lookup(replica.value, "consistency_mode", null)
      deletion_protection_enabled = lookup(replica.value, "deletion_protection_enabled", null)
      kms_key_arn                 = lookup(replica.value, "kms_key_arn", null)
      point_in_time_recovery      = lookup(replica.value, "point_in_time_recovery", null)
      propagate_tags              = lookup(replica.value, "propagate_tags", null)
      region_name                 = replica.value.region_name
    }
  }

  dynamic "server_side_encryption" {
    for_each = var.server_side_encryption != null ? [var.server_side_encryption] : []
    content {
      enabled     = server_side_encryption.value.enabled
      kms_key_arn = lookup(server_side_encryption.value, "kms_key_arn", null)
    }
  }

  dynamic "ttl" {
    for_each = var.ttl != null ? [var.ttl] : []
    content {
      enabled        = ttl.value.enabled
      attribute_name = lookup(ttl.value, "attribute_name", null)
    }
  }

  dynamic "warm_throughput" {
    for_each = var.warm_throughput != null ? [var.warm_throughput] : []
    content {
      read_units_per_second  = lookup(warm_throughput.value, "read_units_per_second", null)
      write_units_per_second = lookup(warm_throughput.value, "write_units_per_second", null)
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []
    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = var.tags
}
