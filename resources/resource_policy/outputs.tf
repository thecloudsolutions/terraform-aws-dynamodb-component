output "id" {
  value       = aws_dynamodb_resource_policy.this.id
  description = "ARN of the resource with the policy."
}

output "revision_id" {
  value       = aws_dynamodb_resource_policy.this.revision_id
  description = "Revision ID of the resource policy."
}
