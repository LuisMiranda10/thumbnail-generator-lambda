resource "aws_s3_bucket" "source_bucket" {
    bucket = "${var.source_bucket_prefix}-image"
}

resource "aws_s3_bucket" "dest_bucket" {
    bucket = "${var.dest_bucket_prefix}-thumbnail"
}