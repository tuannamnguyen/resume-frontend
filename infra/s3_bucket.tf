locals {
  s3_origin_id = "my_fe_s3_origin"
}

resource "aws_s3_bucket" "frontend_bucket" {
  bucket        = local.domain_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "fe-bucket-versioning"   {
  bucket = aws_s3_bucket.frontend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

locals {
  assets_directory = "${path.root}/../assets/"
  css_directory    = "${path.root}/../css/"

  mime_types = {
    htm  = "text/html"
    html = "text/html"
    css  = "text/css"
    ttf  = "font/ttf"
    js   = "application/javascript"
    map  = "application/javascript"
    json = "application/json"
    jpg  = "image/jpeg"
    ico  = "image/x-icon"
  }

}

resource "aws_s3_object" "index_file" {
  bucket       = aws_s3_bucket.frontend_bucket.id
  key          = "index.html"
  source       = "../index.html"
  content_type = "text/html"
}


resource "aws_s3_object" "assets_folder" {
  for_each = fileset(local.assets_directory, "**/*.*")

  bucket = aws_s3_bucket.frontend_bucket.id

  key          = "assets/${replace(each.value, local.assets_directory, "")}"
  source       = "${local.assets_directory}${each.value}"
  content_type = lookup(local.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}

resource "aws_s3_object" "css_folder" {
  for_each = fileset(local.css_directory, "**/*.*")

  bucket = aws_s3_bucket.frontend_bucket.id

  key          = "css/${replace(each.value, local.css_directory, "")}"
  source       = "${local.css_directory}${each.value}"
  content_type = lookup(local.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}
