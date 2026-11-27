variable "approximate_creation_date_time_precision" {
  type        = string
  default     = null
  description = "(Optional) Precision of item creation timestamps. Valid values are MILLISECOND and MICROSECOND."
}

variable "region" {
  type        = string
  default     = null
  description = "(Optional) Region where this resource will be managed. Defaults to the Region set in the provider configuration."
}

variable "stream_arn" {
  type        = string
  description = "(Required) ARN of the Kinesis data stream. The stream must be in the same account and Region as the table."
}

variable "table_name" {
  type        = string
  description = "(Required) Name of the table associated with the streaming destination."
}
