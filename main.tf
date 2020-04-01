provider "aws" {
  region = "us-east-1"
}

resource "random_pet" "petname" {
  length    = 3
  separator = "-"
}

resource "aws_s3_bucket" "bucket" {
  bucket = random_pet.petname.id
  acl    = "public-read"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${random_pet.petname.id}/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"

  }
  force_destroy = true
}

resource "aws_s3_bucket_object" "index" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.bucket.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"

}

output "website_endpoint" {
  value = "http://${aws_s3_bucket.bucket.website_endpoint}/index.html"
}
