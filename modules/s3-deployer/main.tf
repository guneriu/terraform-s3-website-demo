resource "aws_iam_user" "user" {
  name = "s3-deployer"
}

resource "aws_iam_access_key" "user" {
  user = "${aws_iam_user.user.name}"
}

resource "aws_iam_user_policy" "user" {
  name = "s3-deployer-user-access"
  user = "${aws_iam_user.user.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["s3:ListBucket"],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.redirect_test.bucket_domain_name}"
    },
    {
      "Action": [
        "s3:DeleteObject",
        "s3:GetObject",
        "s3:GetObjectAcl",
        "s3:ListBucket",
        "s3:PutObject",
        "s3:PutObjectAcl"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.redirect_test.bucket_domain_name}/*"
    },
    {
      "Action": ["cloudfront:CreateInvalidation"],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}



resource "aws_route53_record" "demo" {

  name = local.domainName
  type = "CNAME"

  alias {
    name = "S3-${aws_s3_bucket.redirect_test.website_endpoint}"
    zone_id = aws_s3_bucket.redirect_test.hosted_zone_id
    evaluate_target_health = false
  }

  zone_id = data.aws_route53_zone.acme-zone.zone_id
}

resource "aws_s3_bucket" "redirect_test" {
  bucket = local.domainName

  tags = {
    Name = "My bucket"
    Reason = "test"
    Environment = var.stage
  }

  website {
    redirect_all_requests_to = "https://routing.${local.zoneName}"
  }

}




