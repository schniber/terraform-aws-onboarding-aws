data "aws_iam_policy_document" "orca_security_client_policy" {
  dynamic "statement" {
    for_each = var.deployment_strategy == "SaaS" ? [1] : []

    content {
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
  }
  dynamic "statement" {
    for_each = var.deployment_strategy == "SaaS" ? [1] : []

    content {
      sid    = "AllowSnapshotDeletion"
      effect = "Allow"
      actions = [
        "ec2:DeleteSnapshot",
      ]
      resources = ["*"]
      condition {
        test     = "StringLike"
        variable = "ec2:ResourceTag/Orca"
        values   = ["*"]
      }
      condition {
        test     = "StringNotLikeIfExists"
        variable = "ec2:ResourceTag/OrcaOptOut"
        values   = ["*"]
      }
    }
  }
  dynamic "statement" {
    for_each = var.deployment_strategy == "SaaS" ? [1] : []

    content {
      sid    = "AllowCreateCopyAndModifySnapshotAttribute"
      effect = "Allow"
      actions = [
        "ec2:CreateSnapshots",
        "ec2:CreateSnapshot",
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
  }
  dynamic "statement" {
    for_each = var.deployment_strategy == "SaaS" ? [1] : []

    content {
      sid    = "AllowKMSOPerations"
      effect = "Allow"
      actions = [
        "kms:ReEncryptFrom",
        "kms:ReEncryptTo",
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:GenerateDataKeyWithoutPlaintext",
        "kms:CreateGrant"
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
  }
  dynamic "statement" {
    for_each = var.deployment_strategy == "SaaS" ? [1] : []

    content {
      sid    = "AllowKMSPutKeyPolicy"
      effect = "Allow"
      actions = [
        "kms:PutKeyPolicy"
      ]
      resources = ["*"]
      condition {
        test     = "StringNotLikeIfExists"
        variable = "ec2:ResourceTag/OrcaOptOut"
        values   = ["*"]
      }
    }
  }
  dynamic "statement" {
    for_each = var.deployment_strategy == "In-account" ? [1] : []

    content {
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
  }
  dynamic "statement" {
    for_each = var.deployment_strategy == "In-account" ? [1] : []

    content {
      sid    = "AllowSnapshotCreation"
      effect = "Allow"
      actions = [
        "ec2:CreateSnapshot",
        "ec2:CreateSnapshots"
      ]
      resources = ["*"]
      condition {
        test     = "StringNotLikeIfExists"
        variable = "ec2:ResourceTag/OrcaOptOut"
        values   = ["*"]
      }
    }
  }
  dynamic "statement" {
    for_each = var.deployment_strategy == "In-account" ? [1] : []

    content {
      sid    = "AllowSnapshotDeletion"
      effect = "Allow"
      actions = [
        "ec2:DeleteSnapshot",
      ]
      resources = ["*"]
      condition {
        test     = "StringLike"
        variable = "ec2:ResourceTag/Orca"
        values   = ["*"]
      }
      condition {
        test     = "StringNotLikeIfExists"
        variable = "ec2:ResourceTag/OrcaOptOut"
        values   = ["*"]
      }
    }
  }
}

module "orca_security_client_policy" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=v5.2.0"

  name        = var.orca_security_client_policy_name
  path        = var.iam_path
  description = var.orca_security_role_description
  policy      = data.aws_iam_policy_document.orca_security_client_policy.json

  tags = var.tags
}
