data "aws_iam_policy_document" "orca_security_rds_snapshot_creation_policy" {
  count = var.enable_rds_access ? 1 : 0

  statement {
    sid    = "AllowRDSTaggingAndSnashotDeletion"
    effect = "Allow"
    actions = [
      "rds:AddTagsToResource",
      "rds:DeleteDBSnapshot",
      "rds:DeleteDBClusterSnapshot"
    ]
    resources = [
      format("arn:%s:rds:*:*:snapshot:*", data.aws_partition.current.partition),
      format("arn:%s:rds:*:*:cluster-snapshot:*", data.aws_partition.current.partition)
    ]
    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/Orca"
      values   = ["*"]
    }
    condition {
      test     = "StringNotLikeIfExists"
      variable = "aws:ResourceTag/OrcaOptOut"
      values   = ["*"]
    }
  }
  statement {
    sid    = "AllowCreateandCopyDBSnapshots"
    effect = "Allow"
    actions = [
      "rds:CreateDBSnapshot",
      "rds:CreateDBClusterSnapshot",
      "rds:CopyDBSnapshot",
      "rds:CopyDBClusterSnapshot"
    ]
    resources = [
      format("arn:%s:rds:*:*:db:*", data.aws_partition.current.partition),
      format("arn:%s:rds:*:*:cluster:*", data.aws_partition.current.partition),
      format("arn:%s:rds:*:*:snapshot:*", data.aws_partition.current.partition),
      format("arn:%s:rds:*:*:cluster-snapshot:*", data.aws_partition.current.partition)
    ]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:TagKeys"
      values = [
        "Orca"
      ]
    }
    condition {
      test     = "StringNotLikeIfExists"
      variable = "aws:ResourceTag/OrcaOptOut"
      values   = ["*"]
    }
  }
}

module "orca_security_rds_snapshot_creation_policy" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=v5.2.0"
  count  = var.enable_rds_access ? 1 : 0

  name        = var.orca_security_rds_snapshot_creation_policy_name
  path        = var.iam_path
  description = "Orca Security RDS Snapshot Creation Policy"
  policy      = one(data.aws_iam_policy_document.orca_security_rds_snapshot_creation_policy[*].json)

  tags = var.tags
}

data "aws_iam_policy_document" "orca_security_rds_snapshot_reencryption_policy" {
  count = var.enable_rds_access ? 1 : 0

  statement {
    sid    = "AllowCreateGrantForDbSnapshotReencryption"
    effect = "Allow"
    actions = [
      "kms:CreateGrant"
    ]
    resources = [
      format("arn:%s:kms:*:*:key/*", data.aws_partition.current.partition)
    ]
    condition {
      test     = "ForAllValues:StringLike"
      variable = "kms:GrantOperations"
      values = [
        "DescribeKey",
        "Decrypt",
        "Encrypt",
        "GenerateDataKeyWithoutPlaintext",
        "CreateGrant",
        "RetireGrant"
      ]
    }
    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values = [
        "true"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "aws:ResourceAccount"
      values = [
        "$${aws:PrincipalTag/OrcaScannerAccountId, '*'}"
      ]
    }
    condition {
      test     = "ForAnyValue:StringLike"
      variable = "kms:ViaService"
      values = [
        "rds.*.amazonaws.com"
      ]
    }
  }
  statement {
    sid    = "AllowDescribeKeyForDbSnapshotReencryption"
    effect = "Allow"
    actions = [
      "kms:DescribeKey"
    ]
    resources = [
      format("arn:%s:kms:*:*:key/*", data.aws_partition.current.partition)
    ]
    condition {
      test     = "StringLike"
      variable = "aws:ResourceAccount"
      values = [
        "$${aws:PrincipalTag/OrcaScannerAccountId, '*'}"
      ]
    }
    condition {
      test     = "ForAnyValue:StringLike"
      variable = "kms:ViaService"
      values = [
        "rds.*.amazonaws.com"
      ]
    }
  }
  statement {
    sid    = "AllowTagging"
    effect = "Allow"
    actions = [
      "rds:AddTagsToResource"
    ]
    resources = [
      format("arn:%s:rds:*:*:snapshot:*", data.aws_partition.current.partition),
      format("arn:%s:rds:*:*:cluster-snapshot:*", data.aws_partition.current.partition)
    ]
    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/Orca"
      values   = ["*"]
    }
    condition {
      test     = "StringNotLikeIfExists"
      variable = "aws:ResourceTag/OrcaOptOut"
      values   = ["*"]
    }
  }
  statement {
    sid    = "AllowCopyDbSnapshots"
    effect = "Allow"
    actions = [
      "rds:CopyDBSnapshot",
      "rds:CopyDBClusterSnapshot"
    ]
    resources = [
      format("arn:%s:rds:*:*:snapshot:*", data.aws_partition.current.partition),
      format("arn:%s:rds:*:*:cluster-snapshot:*", data.aws_partition.current.partition)
    ]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:TagKeys"
      values   = ["Orca"]
    }
    condition {
      test     = "StringNotLikeIfExists"
      variable = "aws:ResourceTag/OrcaOptOut"
      values   = ["*"]
    }
  }
}

module "orca_security_rds_snapshot_reencryption_policy" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=v5.2.0"
  count  = var.enable_rds_access ? 1 : 0

  name        = var.orca_security_rds_snapshot_reencryption_policy_name
  path        = var.iam_path
  description = "Orca Security RDS Snapshot Re-Encryption Policy"
  policy      = one(data.aws_iam_policy_document.orca_security_rds_snapshot_reencryption_policy[*].json)

  tags = var.tags
}

data "aws_iam_policy_document" "orca_security_rds_snapshot_sharing_policy" {
  count = var.enable_rds_access ? 1 : 0

  statement {
    sid    = "AllowModifyDbSnapshots"
    effect = "Allow"
    actions = [
      "rds:ModifyDBSnapshotAttribute",
      "rds:ModifyDBClusterSnapshotAttribute"
    ]
    resources = [
      format("arn:%s:rds:*:*:snapshot:*", data.aws_partition.current.partition),
      format("arn:%s:rds:*:*:cluster-snapshot:*", data.aws_partition.current.partition)
    ]
    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/Orca"
      values   = ["*"]
    }
    condition {
      test     = "StringNotLikeIfExists"
      variable = "aws:ResourceTag/OrcaOptOut"
      values   = ["*"]
    }
  }
}

module "orca_security_rds_snapshot_sharing_policy" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=v5.2.0"
  count  = var.enable_rds_access ? 1 : 0

  name        = var.orca_security_rds_snapshot_sharing_policy_name
  path        = var.iam_path
  description = "Orca Security RDS Snapshot Sharing Policy"
  policy      = one(data.aws_iam_policy_document.orca_security_rds_snapshot_sharing_policy[*].json)

  tags = var.tags
}
