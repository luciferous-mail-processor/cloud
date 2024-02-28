resource "aws_s3_bucket" "mailbox" {
  bucket_prefix = "mailbox-"
}

data "aws_iam_policy_document" "bucket_policy_mailbox" {
  policy_id = "bucket_policy_mailbox"
  statement {
    sid    = "bucket_policy_mailbox"
    effect = "Allow"
    principals {
      identifiers = ["ses.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.mailbox.arn}/*"]

    condition {
      test     = "StringEquals"
      values   = [data.aws_caller_identity.current.account_id]
      variable = "AWS:SourceAccount"
    }

    condition {
      test     = "StringEquals"
      values   = [aws_ses_receipt_rule.mailbox.arn]
      variable = "AWS:SourceArn"
    }
  }
}

resource "aws_s3_bucket_policy" "mailbox" {
  bucket = ""
  policy = ""
}