data "aws_iam_policy_document" "orca_security_secrets_manager_access_policy" {
  count = var.deployment_strategy == "SaaS" && var.enable_secrets_manager_access ? 1 : 0

  statement {
    sid    = "AllowGetSecretValue"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = [
      format("arn:%s:secretsmanager:*:*:secret:*", data.aws_partition.current.partition)
    ]
    condition {
      test     = "StringLike"
      variable = "secretsmanager:ResourceTag/Orca"
      values = [
        "SecretAccess"
      ]
    }
  }
  statement {
    sid    = "AllowKMSDecrypt"
    effect = "Allow"
    actions = [
      "kms:Decrypt"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "secretsmanager:ResourceTag/Orca"
      values = [
        "SecretAccess"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "kms:ViaService"
      values = [
        "secretsmanager.*.amazonaws.com"
      ]
    }
  }
}

module "orca_security_secrets_manager_policy" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=v5.2.0"
  count  = var.deployment_strategy == "SaaS" && var.enable_secrets_manager_access ? 1 : 0

  name        = var.orca_security_secrets_manager_policy_name
  path        = var.iam_path
  description = "Orca Security Secrets Manager Policy"
  policy      = one(data.aws_iam_policy_document.orca_security_secrets_manager_access_policy[*].json)

  tags = var.tags
}
