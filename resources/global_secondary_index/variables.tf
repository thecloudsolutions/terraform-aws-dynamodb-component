variable "index_name" {
  type        = string
  description = "(Required) Name of the global secondary index."
}

variable "key_schema" {
  type = list(object({
    attribute_name = string
    # (Required) Name of the key attribute.
    attribute_type = string
    # (Required) Attribute type. Valid values are S, N, and B.
    key_type = string
    # (Required) Key type. Valid values are HASH and RANGE.
  }))
  description = "(Required) Ordered key definitions. All HASH keys must precede RANGE keys."
}

variable "on_demand_throughput" {
  type = object({
    max_read_request_units = optional(number)
    # (Optional) Maximum number of read request units for the index.
    max_write_request_units = optional(number)
    # (Optional) Maximum number of write request units for the index.
  })
  default     = null
  description = "(Optional) Maximum throughput for an index on a PAY_PER_REQUEST table."
}

variable "projection" {
  type = object({
    non_key_attributes = optional(set(string))
    # (Optional) Additional attributes to project when projection_type is INCLUDE.
    projection_type = string
    # (Required) Projection type. Valid values are ALL, INCLUDE, and KEYS_ONLY.
  })
  default     = null
  description = "(Optional) Attributes projected into the index. Required when creating an index."
}

variable "provisioned_throughput" {
  type = object({
    read_capacity_units = optional(number)
    # (Optional) Number of read capacity units. Required when creating a provisioned index.
    write_capacity_units = optional(number)
    # (Optional) Number of write capacity units. Required when creating a provisioned index.
  })
  default     = null
  description = "(Optional) Provisioned throughput. Required when the table billing_mode is PROVISIONED."
}

variable "region" {
  type        = string
  default     = null
  description = "(Optional) Region where this resource will be managed. Defaults to the Region set in the provider configuration."
}

variable "table_name" {
  type        = string
  description = "(Required) Name of the table. Do not combine standalone indexes with inline global_secondary_index blocks on the same table."
}

variable "warm_throughput" {
  type = object({
    read_units_per_second = optional(number)
    # (Optional) Number of read operations the index can instantaneously support.
    write_units_per_second = optional(number)
    # (Optional) Number of write operations the index can instantaneously support.
  })
  default     = null
  description = "(Optional) Warm throughput configuration for the index."
}

variable "timeouts" {
  type = object({
    create = optional(string)
    # (Optional) Timeout for index creation. Defaults to 30 minutes.
    update = optional(string)
    # (Optional) Timeout for index updates. Defaults to 60 minutes.
    delete = optional(string)
    # (Optional) Timeout for index deletion. Defaults to 10 minutes.
  })
  default     = null
  description = "(Optional) Configuration block for resource timeouts."
}
