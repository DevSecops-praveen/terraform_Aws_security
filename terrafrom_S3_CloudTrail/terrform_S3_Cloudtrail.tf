#Using Static credentials: Credentials can be provided by adding an access_key and secret_key in-line in the AWS provider block:
#Warning: Hard-coding credentials into any Terraform configuration is not recommended, and risks secret leakage should this file ever be committed to a public version control system.

# Configure the AWS Provider
provider "aws" {
  region     = "ap-south-1"
  access_key = "xxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxx"
}
#Create s3 bucket
resource "aws_s3_bucket" "chagact19855" {
  region = "ap-south-1"
  bucket = "chagact19855"

  versioning {
    enabled = false
  }
}
#create bucket policy
resource "aws_s3_bucket_policy" "ctrails3" {
  bucket = "${aws_s3_bucket.chagact19855.id}"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck20150319",
            "Effect": "Allow",
            "Principal": {"Service": "cloudtrail.amazonaws.com"},
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::chagact19855"
        },
        {
            "Sid": "AWSCloudTrailWrite20150319",
            "Effect": "Allow",
            "Principal": {"Service": "cloudtrail.amazonaws.com"},
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::chagact19855/*",
            "Condition": {"StringEquals": {"s3:x-amz-acl": "bucket-owner-full-control"}}
        }
    ]
}
POLICY
}
#create cloudtrail
resource "aws_cloudtrail" "ct-ap-south-1" {
  name                          = "ct-ap-south-1"
  s3_bucket_name                = "${aws_s3_bucket.chagact19855.id}"
  include_global_service_events = true
  is_multi_region_trail         = false
  is_organization_trail         = false
  enable_log_file_validation    = true

}
