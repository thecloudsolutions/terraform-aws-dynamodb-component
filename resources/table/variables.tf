variable "attribute" {
  type = list(object({
    name = string
    # (Required) Name of the attribute
    type = string
    # (Required) Attribute type. Valid values are S (string), N (number), B (binary).
  }))
  default     = []
  description = "(Optional) Set of nested attribute definitions. Required for configured table and index key attributes."
}

variable "hash_key" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) Attribute to use as the hash (partition) key. Must also be defined as an attribute."
}

variable "name" {
  type        = string
  description = "(Required) Unique within a region name of the table."
}

variable "billing_mode" {
  type        = string
  default     = null
  description = "(Optional) Controls how you are charged for read and write throughput and how you manage capacity. The valid values are PROVISIONED and PAY_PER_REQUEST. Defaults to PROVISIONED."
}

variable "deletion_protection_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Enables deletion protection for table. Defaults to false."
}

variable "region" {
  type        = string
  default     = null
  description = "(Optional) Region where this resource will be managed. Defaults to the Region set in the provider configuration."
}

variable "global_secondary_index" {
  type = list(object({
    hash_key = optional(string)
    # (Optional, Deprecated) Name of the hash key in the index; must be defined as an attribute in the resource. Mutually exclusive with key_schema. Use key_schema instead.
    key_schema = optional(list(object({
      attribute_name = string
      # (Required) Name of the attribute; must be defined as an attribute in the resource.
      key_type = string
      # (Required) Type of key. Valid values are HASH and RANGE.
    })), [])
    # (Optional) Configuration blocks for the index key schema. Mutually exclusive with hash_key and range_key.
    name = string
    # (Required) Name of the index.
    non_key_attributes = optional(list(string))
    # (Optional) Only required with INCLUDE as a projection type; a list of attributes to project into the index. These do not need to be defined as attributes on the table.
    projection_type = string
    # (Required) One of ALL, INCLUDE or KEYS_ONLY where ALL projects every attribute into the index, KEYS_ONLY projects into the index only the table and index hash_key and sort_key attributes , INCLUDE projects into the index all of the attributes that are defined in non_key_attributes in addition to the attributes that thatKEYS_ONLY project.
    range_key = optional(string)
    # (Optional) Name of the range key; must be defined
    read_capacity = optional(number)
    # (Optional) Number of read units for this index. Must be set if billing_mode is set to PROVISIONED.
    on_demand_throughput = optional(object({
      max_read_request_units = optional(number)
      # (Optional) Maximum number of read request units for the index.
      max_write_request_units = optional(number)
      # (Optional) Maximum number of write request units for the index.
    }))
    # (Optional) Maximum on-demand throughput for the index.
    warm_throughput = optional(object({
      read_units_per_second = optional(number)
      # (Optional) Number of read operations the index can instantaneously support.
      write_units_per_second = optional(number)
      # (Optional) Number of write operations the index can instantaneously support.
    }))
    # (Optional) Warm throughput settings for the index.
    write_capacity = optional(number)
    # (Optional) Number of write units for this index. Must be set if billing_mode is set to PROVISIONED.
  }))
  default     = []
  description = "(Optional) Describe a GSI for the table; subject to the normal limits on the number of GSIs, projected attributes, etc."
}

variable "global_table_witness" {
  type = object({
    region_name = optional(string)
    # (Optional, Computed) Name of the AWS Region that serves as a witness for the MRSC global table.
  })
  default     = null
  description = "(Optional) Witness Region in a Multi-Region Strong Consistency deployment."
}

variable "import_table" {
  type = object({
    input_compression_type = optional(string)
    # (Optional) Type of compression used on the input. Valid values are GZIP, ZSTD, and NONE.
    input_format = string
    # (Required) Format of the source data. Valid values are CSV, DYNAMODB_JSON, and ION.
    input_format_options = optional(object({
      csv = optional(object({
        delimiter = optional(string)
        # (Optional) Delimiter used for separating items in imported CSV files.
        header_list = optional(set(string))
        # (Optional) Headers used to specify a common header for all imported CSV files.
      }))
      # (Optional) CSV processing options.
    }))
    # (Optional) Format-specific options for the imported data.
    s3_bucket_source = object({
      bucket = string
      # (Required) S3 bucket containing the source data.
      bucket_owner = optional(string)
      # (Optional) Account number of the S3 bucket owner.
      key_prefix = optional(string)
      # (Optional) Key prefix shared by the source objects.
    })
    # (Required) S3 bucket source for the imported data.
  })
  default     = null
  description = "(Optional) Import Amazon S3 data into a new table."
}

variable "local_secondary_index" {
  type = list(object({
    name = string
    # (Required) Name of the index
    non_key_attributes = optional(list(string))
    # (Optional) Only required with INCLUDE as a projection type; a list of attributes to project into the index. These do not need to be defined as attributes on the table.
    projection_type = string
    # (Required) One of ALL, INCLUDE or KEYS_ONLY where ALL projects every attribute into the index, KEYS_ONLY projects into the index only the table and index hash_key and sort_key attributes , INCLUDE projects into the index all of the attributes that are defined in non_key_attributes in addition to the attributes that thatKEYS_ONLY project.
    range_key = string
    # (Required) Name of the range key
  }))
  default     = []
  description = "(Optional, Forces new resource) Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource."
}

variable "point_in_time_recovery" {
  type = object({
    enabled = bool
    # (Required) Whether to enable point-in-time recovery. It can take 10 minutes to enable for new tables. If the point_in_time_recovery block is not provided, this defaults to false.
    recovery_period_in_days = optional(number)
    # (Optional) Number of preceding days for which continuous backups are taken and maintained. Default is 35.
  })
  default     = null
  description = "(Optional) Enable point-in-time recovery options."
}

variable "on_demand_throughput" {
  type = object({
    max_read_request_units = optional(number)
    # (Optional) Maximum number of read request units for the table.
    max_write_request_units = optional(number)
    # (Optional) Maximum number of write request units for the table.
  })
  default     = null
  description = "(Optional) Maximum read and write request units for the on-demand table."
}

variable "range_key" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) Attribute to use as the range (sort) key. Must also be defined as an attribute."
}

variable "read_capacity" {
  type        = number
  default     = null
  description = "(Optional) Number of read units for this table. If the billing_mode is PROVISIONED, this field is required."
}

variable "replica" {
  type = list(object({
    consistency_mode = optional(string)
    # (Optional) Consistency mode for the global table. Valid values are EVENTUAL and STRONG. Defaults to EVENTUAL.
    deletion_protection_enabled = optional(bool)
    # (Optional) Whether deletion protection is enabled on the replica. Defaults to false.
    kms_key_arn = optional(string)
    # (Optional, Forces new resource) ARN of the CMK that should be used for the AWS KMS encryption. This argument should only be used if the key is different from the default KMS-managed DynamoDB key, alias/aws/dynamodb. Note: This attribute will not be populated with the ARN of default keys.
    point_in_time_recovery = optional(bool)
    # (Optional) Whether to enable Point In Time Recovery for the replica. Default is false.
    propagate_tags = optional(bool)
    # (Optional) Whether to propagate the global table's tags to a replica. Default is false. Changes to tags only move in one direction: from global (source) to replica. In other words, tag drift on a replica will not trigger an update. Tag or replica changes on the global table, whether from drift or configuration changes, are propagated to replicas. Changing from true to false on a subsequent apply means replica tags are left as they were, unmanaged, not deleted.
    region_name = string
    # (Required) Region name of the replica.
  }))
  default     = []
  description = "(Optional) Configuration block(s) with DynamoDB Global Tables V2 (version 2019.11.21) replication configurations."
}

variable "restore_backup_arn" {
  type        = string
  default     = null
  description = "(Optional) ARN of the backup to restore."
}

variable "restore_date_time" {
  type        = string
  default     = null
  description = "(Optional) Time of the point-in-time recovery point to restore."
}

variable "restore_source_name" {
  type        = string
  default     = null
  description = "(Optional) Name of the table to restore. Must match the name of an existing table."
}

variable "restore_source_table_arn" {
  type        = string
  default     = null
  description = "(Optional) ARN of the source table to restore. Must be supplied for cross-region restores."
}

variable "restore_to_latest_time" {
  type        = bool
  default     = null
  description = "(Optional) If set, restores table to the most recent point-in-time recovery point."
}

variable "server_side_encryption" {
  type = object({
    enabled = bool
    # (Required) Whether or not to enable encryption at rest using an AWS managed KMS customer master key (CMK). If enabled is false then server-side encryption is set to AWS-owned key (shown as DEFAULT in the AWS console). Potentially confusingly, if enabled is true and no kms_key_arn is specified then server-side encryption is set to the default KMS-managed key (shown as KMS in the AWS console). The AWS KMS documentation explains the difference between AWS-owned and KMS-managed keys.
    kms_key_arn = optional(string)
    # (Optional) ARN of the CMK that should be used for the AWS KMS encryption. This argument should only be used if the key is different from the default KMS-managed DynamoDB key, alias/aws/dynamodb. Note: This attribute will not be populated with the ARN of default keys.
  })
  default     = null
  description = "(Optional) Encryption at rest options. AWS DynamoDB tables are automatically encrypted at rest with an AWS-owned Customer Master Key if this argument isn't specified."
}

variable "stream_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Whether Streams are enabled."
}

variable "stream_view_type" {
  type        = string
  default     = null
  description = "(Optional) When an item in the table is modified, StreamViewType determines what information is written to the table's stream. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES"
}

variable "table_class" {
  type        = string
  default     = null
  description = "(Optional) Storage class of the table. Valid values are STANDARD and STANDARD_INFREQUENT_ACCESS. Default value is STANDARD"
}

variable "ttl" {
  type = object({
    enabled = optional(bool)
    # (Optional) Whether TTL is enabled. Defaults to false.
    attribute_name = optional(string)
    # (Optional) Name of the table attribute to store the TTL timestamp in. Required when enabled is true.
  })
  default     = null
  description = "(Optional) Configuration block for TTL."
}

variable "warm_throughput" {
  type = object({
    read_units_per_second = optional(number)
    # (Optional) Number of read operations the table can instantaneously support.
    write_units_per_second = optional(number)
    # (Optional) Number of write operations the table can instantaneously support.
  })
  default     = null
  description = "(Optional) Warm read and write throughput settings for the table."
}

variable "write_capacity" {
  type        = number
  default     = null
  description = "(Optional) Number of write units for this table. If the billing_mode is PROVISIONED, this field is required."
}

variable "timeouts" {
  type = object({
    create = optional(string)
    # Default 30 minutes
    update = optional(string)
    # Default 60 minutes
    delete = optional(string)
    # Default 10 minutes
  })
  default     = null
  description = "(Optional) Timeouts for the service."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) A map of tags assigned to all modules."
}
