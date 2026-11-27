resource "aws_dynamodb_global_secondary_index" "this" {
  index_name      = var.index_name
  region          = var.region
  table_name      = var.table_name
  warm_throughput = var.warm_throughput

  dynamic "key_schema" {
    for_each = var.key_schema
    content {
      attribute_name = key_schema.value.attribute_name
      attribute_type = key_schema.value.attribute_type
      key_type       = key_schema.value.key_type
    }
  }

  dynamic "on_demand_throughput" {
    for_each = var.on_demand_throughput != null ? [var.on_demand_throughput] : []
    content {
      max_read_request_units  = lookup(on_demand_throughput.value, "max_read_request_units", null)
      max_write_request_units = lookup(on_demand_throughput.value, "max_write_request_units", null)
    }
  }

  dynamic "projection" {
    for_each = var.projection != null ? [var.projection] : []
    content {
      non_key_attributes = lookup(projection.value, "non_key_attributes", null)
      projection_type    = projection.value.projection_type
    }
  }

  dynamic "provisioned_throughput" {
    for_each = var.provisioned_throughput != null ? [var.provisioned_throughput] : []
    content {
      read_capacity_units  = lookup(provisioned_throughput.value, "read_capacity_units", null)
      write_capacity_units = lookup(provisioned_throughput.value, "write_capacity_units", null)
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
}
