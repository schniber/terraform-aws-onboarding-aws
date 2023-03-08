data "aws_iam_policy_document" "orca_security_in_account_client_to_scanner_policy" {
  count = var.deployment_strategy == "In-account" ? 1 : 0

  statement {
    sid    = "AllowTagCreation"
    effect = "Allow"
    actions = [
      "ec2:CreateTags",
    ]
    resources = [
      format("arn:%s:ec2:*::snapshot/*", data.aws_partition.current.partition)
    ]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:TagKeys"
      values = [
        "Orca"
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "ec2:CreateAction"
      values = [
        "CreateSnapshot",
        "CreateSnapshots",
        "CopySnapshot"
      ]
    }
  }
  statement {
    sid    = "AllowSnapshotCreation"
    effect = "Allow"
    actions = [
      "ec2:CopySnapshot",
      "ec2:ModifySnapshotAttribute"
    ]
    resources = ["*"]
    condition {
      test     = "StringNotLikeIfExists"
      variable = "ec2:ResourceTag/OrcaOptOut"
      values   = ["*"]
    }
  }
  statement {
    sid    = "AllowDescribeSnapshotsAndImages"
    effect = "Allow"
    actions = [
      "ec2:DescribeSnapshots",
      "ec2:DescribeImages"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowKMSOperations"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:ReEncryptFrom",
      "kms:ReEncryptTo",
      "kms:CreateGrant",
      "kms:GenerateDataKeyWithoutPlaintext"
    ]
    resources = ["*"]
    condition {
      test     = "StringNotLikeIfExists"
      variable = "ec2:ResourceTag/OrcaOptOut"
      values   = ["*"]
    }
    condition {
      test     = "StringLike"
      variable = "kms:ViaService"
      values = [
        "ec2.*.amazonaws.com"
      ]
    }
  }
  statement {
    sid    = "AllowKMSOperations1"
    effect = "Allow"
    actions = [
      "kms:DescribeKey",
      "kms:GetKeyPolicy",
      "kms:PutKeyPolicy"
    ]
    resources = ["*"]
    condition {
      test     = "StringNotLikeIfExists"
      variable = "aws:ResourceTag/OrcaOptOut"
      values   = ["*"]
    }
  }
}

module "orca_security_in_account_client_to_scanner_policy" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=v5.2.0"
  count  = var.deployment_strategy == "In-account" ? 1 : 0

  name        = var.orca_security_in_account_client_to_scanner_policy_name
  path        = var.iam_path
  description = "Orca Security Side Scanner Policy"
  policy      = one(data.aws_iam_policy_document.orca_security_in_account_client_to_scanner_policy[*].json)

  tags = var.tags
}
