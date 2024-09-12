resource "aws_s3_bucket" "source_bucket" {
    bucket = "${var.source_bucket_prefix}-image"
    tags = merge(local.common_tags, {
        name = "${local.namespaced_service_name}-source-bucket"
    })
}

resource "aws_s3_bucket" "dest_bucket" {
    bucket = "${var.dest_bucket_prefix}-thumbnail"
    tags = merge(local.common_tags, {
        name = "${local.namespaced_service_name}-destination-bucket"
    })
}

