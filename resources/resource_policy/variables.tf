variable "resource_arn" {
  type        = string
  description = "(Required) ARN of the DynamoDB table or stream to which the policy is attached."
}

variable "policy" {
  type        = string
  description = "(Required) Resource policy document in JSON format."
}

variable "region" {
  type        = string
  default     = null
  description = "(Optional) Region where this resource will be managed. Defaults to the provider Region."
}

variable "confirm_remove_self_resource_access" {
  type        = bool
  default     = null
  description = "(Optional) Confirm removal of permissions to change this resource policy."
}
