resource "aws_ecr_repository" "applicationImage" {
  name = local.name
  tags = merge(local.default_tags, {
    CreatedBy = "Temitayo Jose"
    Created   = "2023-10-28"
  })
}