module "orca_security_role" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-assumable-role?ref=v5.2.0"

  create_role      = true
  role_name        = var.orca_security_role_name
  role_description = var.deployment_strategy == "SaaS" ? "OrcaSecurityRole" : var.deployment_strategy == "In-account" ? "OrcaSecurityRoleSA" : null
  role_path        = var.iam_path
  trusted_role_arns = [
    format("arn:%s:iam::%s:root", data.aws_partition.current.partition, local.orca_vendor_account_id)
  ]
  role_sts_externalid = [
    var.external_id
  ]
  role_requires_mfa = false
  custom_role_policy_arns = var.enable_secrets_manager_access && var.enable_rds_access ? [
    module.orca_security_client_policy.arn,
    one(module.orca_security_secrets_manager_policy[*].arn),
    one(module.orca_security_rds_snapshot_creation_policy[*].arn),
    one(module.orca_security_rds_snapshot_reencryption_policy[*].arn),
    one(module.orca_security_rds_snapshot_sharing_policy[*].arn),
    module.orca_security_view_only_extras_policy.arn,
    local.view_only_access_managed_policy_arn
    ] : var.enable_secrets_manager_access && !var.enable_rds_access ? [
    module.orca_security_client_policy.arn,
    one(module.orca_security_secrets_manager_policy[*].arn),
    module.orca_security_view_only_extras_policy.arn,
    local.view_only_access_managed_policy_arn
    ] : !var.enable_secrets_manager_access && var.enable_rds_access ? [
    module.orca_security_client_policy.arn,
    one(module.orca_security_secrets_manager_policy[*].arn),
    module.orca_security_view_only_extras_policy.arn,
    local.view_only_access_managed_policy_arn
    ] : !var.enable_secrets_manager_access && !var.enable_rds_access ? [
    module.orca_security_client_policy.arn,
    module.orca_security_view_only_extras_policy.arn,
    local.view_only_access_managed_policy_arn
  ] : null

  tags = var.tags
}

module "orca_security_side_scanner_role" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-assumable-role?ref=v5.2.0"

  create_role      = var.deployment_strategy == "In-account"
  role_name        = var.orca_security_side_scanner_role_name
  role_description = var.orca_security_side_scanner_role_description
  role_path        = var.iam_path
  trusted_role_arns = [
    format("arn:%s:iam::%s:root", data.aws_partition.current.partition, data.aws_caller_identity.current.account_id)
  ]
  role_sts_externalid = [
    var.external_id
  ]
  role_requires_mfa = false
  custom_role_policy_arns = var.enable_secrets_manager_access && var.enable_rds_access ? [
    one(module.orca_security_in_account_client_to_scanner_policy[*].arn),
    one(module.orca_security_secrets_manager_policy[*].arn),
    one(module.orca_security_rds_snapshot_creation_policy[*].arn),
    one(module.orca_security_rds_snapshot_reencryption_policy[*].arn),
    one(module.orca_security_rds_snapshot_sharing_policy[*].arn),
    local.read_only_access_managed_policy_arn
    ] : var.enable_secrets_manager_access && !var.enable_rds_access ? [
    one(module.orca_security_in_account_client_to_scanner_policy[*].arn),
    one(module.orca_security_secrets_manager_policy[*].arn),
    local.read_only_access_managed_policy_arn
    ] : !var.enable_secrets_manager_access && var.enable_rds_access ? [
    one(module.orca_security_in_account_client_to_scanner_policy[*].arn),
    one(module.orca_security_rds_snapshot_creation_policy[*].arn),
    one(module.orca_security_rds_snapshot_reencryption_policy[*].arn),
    one(module.orca_security_rds_snapshot_sharing_policy[*].arn),
    local.read_only_access_managed_policy_arn
    ] : !var.enable_secrets_manager_access && !var.enable_rds_access ? [
    one(module.orca_security_in_account_client_to_scanner_policy[*].arn),
    local.read_only_access_managed_policy_arn
  ] : null

  tags = var.tags
}
