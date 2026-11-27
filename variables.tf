variable "dynamodb_map" {
  type = map(object({
    table = object({
      attribute = optional(list(object({
        name = string
        type = string
      })), [])

      hash_key                    = optional(string)
      name                        = string
      billing_mode                = optional(string)
      deletion_protection_enabled = optional(bool)
      region                      = optional(string)

      global_secondary_index = optional(list(object({
        hash_key           = optional(string)
        key_schema         = optional(list(object({ attribute_name = string, key_type = string })), [])
        name               = string
        non_key_attributes = optional(list(string))
        projection_type    = string
        range_key          = optional(string)
        read_capacity      = optional(number)
        on_demand_throughput = optional(object({
          max_read_request_units  = optional(number)
          max_write_request_units = optional(number)
        }))
        warm_throughput = optional(object({
          read_units_per_second  = optional(number)
          write_units_per_second = optional(number)
        }))
        write_capacity = optional(number)
      })), [])

      global_table_witness = optional(object({ region_name = optional(string) }))

      import_table = optional(object({
        input_compression_type = optional(string)
        input_format           = string
        input_format_options = optional(object({
          csv = optional(object({ delimiter = optional(string), header_list = optional(set(string)) }))
        }))
        s3_bucket_source = object({ bucket = string, bucket_owner = optional(string), key_prefix = optional(string) })
      }))

      local_secondary_index = optional(list(object({
        name               = string
        non_key_attributes = optional(list(string))
        projection_type    = string
        range_key          = string
      })), [])

      on_demand_throughput = optional(object({
        max_read_request_units  = optional(number)
        max_write_request_units = optional(number)
      }))

      point_in_time_recovery = optional(object({
        enabled                 = bool
        recovery_period_in_days = optional(number)
      }))

      range_key     = optional(string)
      read_capacity = optional(number)

      replica = optional(list(object({
        consistency_mode            = optional(string)
        deletion_protection_enabled = optional(bool)
        kms_key_arn                 = optional(string)
        point_in_time_recovery      = optional(bool)
        propagate_tags              = optional(bool)
        region_name                 = string
      })), [])

      restore_backup_arn       = optional(string)
      restore_date_time        = optional(string)
      restore_source_name      = optional(string)
      restore_source_table_arn = optional(string)
      restore_to_latest_time   = optional(bool)

      server_side_encryption = optional(object({
        enabled     = bool
        kms_key_arn = optional(string)
      }))

      stream_enabled   = optional(bool)
      stream_view_type = optional(string)
      table_class      = optional(string)

      ttl = optional(object({
        enabled        = optional(bool)
        attribute_name = optional(string)
      }))

      warm_throughput = optional(object({
        read_units_per_second  = optional(number)
        write_units_per_second = optional(number)
      }))

      write_capacity = optional(number)

      timeouts = optional(object({
        create = optional(string)
        update = optional(string)
        delete = optional(string)
      }))

      tags = optional(map(string))
    })

    global_secondary_index_map = optional(map(object({
      index_name = string
      key_schema = list(object({
        attribute_name = string
        attribute_type = string
        key_type       = string
      }))
      on_demand_throughput = optional(object({
        max_read_request_units  = optional(number)
        max_write_request_units = optional(number)
      }))
      projection = optional(object({
        non_key_attributes = optional(set(string))
        projection_type    = string
      }))
      provisioned_throughput = optional(object({
        read_capacity_units  = optional(number)
        write_capacity_units = optional(number)
      }))
      region = optional(string)
      warm_throughput = optional(object({
        read_units_per_second  = optional(number)
        write_units_per_second = optional(number)
      }))
      timeouts = optional(object({
        create = optional(string)
        update = optional(string)
        delete = optional(string)
      }))
    })), {})

    contributor_insights_map = optional(map(object({
      index_name                         = optional(string)
      global_secondary_index_custom_name = optional(string)
      mode                               = optional(string)
      region                             = optional(string)
      timeouts = optional(object({
        create = optional(string)
        delete = optional(string)
      }))
    })), {})

    kinesis_streaming_destination = optional(object({
      approximate_creation_date_time_precision = optional(string)
      region                                   = optional(string)
      stream_arn                               = string
    }))

    table_resource_policy = optional(object({
      policy                              = string
      region                              = optional(string)
      confirm_remove_self_resource_access = optional(bool)
    }))

    stream_resource_policy = optional(object({
      policy                              = string
      region                              = optional(string)
      confirm_remove_self_resource_access = optional(bool)
    }))

    replica_resource_policy_map = optional(map(object({
      policy                              = string
      confirm_remove_self_resource_access = optional(bool)
    })), {})
  }))

  description = "Keyed collection of dynamodb definitions"
}
