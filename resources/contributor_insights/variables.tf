variable "index_name" {
  type        = string
  default     = null
  description = "(Optional) Name of the global secondary index. When omitted, Contributor Insights is enabled for the table."
}

variable "mode" {
  type        = string
  default     = null
  description = "(Optional) Contributor Insights mode. Valid values are ACCESSED_AND_THROTTLED_KEYS and THROTTLED_KEYS. AWS provider 6.60 does not implement in-place mode updates."
}

variable "region" {
  type        = string
  default     = null
  description = "(Optional) Region where this resource will be managed. Defaults to the Region set in the provider configuration."
}

variable "table_name" {
  type        = string
  description = "(Required) Name of the table to enable Contributor Insights."
}

variable "timeouts" {
  type = object({
    create = optional(string)
    # (Optional) Timeout for enabling Contributor Insights. Defaults to 5 minutes.
    delete = optional(string)
    # (Optional) Timeout for disabling Contributor Insights. Defaults to 5 minutes.
  })
  default     = null
  description = "(Optional) Configuration block for resource timeouts."
}
