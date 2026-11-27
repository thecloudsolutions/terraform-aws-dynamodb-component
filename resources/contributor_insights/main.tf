resource "aws_dynamodb_contributor_insights" "this" {
  index_name = var.index_name
  mode       = var.mode
  region     = var.region
  table_name = var.table_name

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []
    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }
}
