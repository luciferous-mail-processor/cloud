resource "aws_ses_receipt_rule_set" "mailbox" {
  rule_set_name = "mailbox"
}

resource "aws_ses_receipt_rule" "mailbox" {
  name          = "mailbox"
  rule_set_name = aws_ses_receipt_rule_set.mailbox.rule_set_name
  recipients    = [var.receive_domain]
  enabled       = true
  scan_enabled  = false
  tls_policy    = "Optional"

  s3_action {
    bucket_name       = aws_s3_bucket.mailbox.bucket
    position          = 1
    object_key_prefix = "mailbox"
  }
}

resource "aws_ses_active_receipt_rule_set" "mailbox" {
  rule_set_name = aws_ses_receipt_rule_set.mailbox.rule_set_name
}