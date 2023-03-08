# README

This module contains infrastructure as code for for managing AWS Account Onboarding to Orca Security.
This module allows to onboard an AWS Account either through SaaS Scanning or In-account Scanning.

## Usage

   Add this module to your terraform configuration and provide the required variables.
   An example of this module instanciation below

 ```hcl
module "onboarding" {
  source = "git::https://github.com/terraform-orca/terraform-aws-onboarding-aws.git?ref=v0.0.1"

  iam_path    = var.iam_path
  external_id = var.external_id

  deployment_strategy                                    = var.deployment_strategy
  orca_security_role_name                                = var.orca_security_role_name
  orca_security_role_description                         = var.orca_security_role_description
  orca_security_side_scanner_role_name                   = var.orca_security_side_scanner_role_name
  orca_security_side_scanner_role_description            = var.orca_security_side_scanner_role_description
  orca_security_client_policy_name                       = var.orca_security_client_policy_name
  orca_security_in_account_client_to_scanner_policy_name = var.orca_security_in_account_client_to_scanner_policy_name
  orca_security_view_only_extras_policy_name             = var.orca_security_view_only_extras_policy_name

  enable_rds_access                                   = var.enable_rds_access
  orca_security_rds_snapshot_creation_policy_name     = var.orca_security_rds_snapshot_creation_policy_name
  orca_security_rds_snapshot_reencryption_policy_name = var.orca_security_rds_snapshot_reencryption_policy_name
  orca_security_rds_snapshot_sharing_policy_name      = var.orca_security_rds_snapshot_sharing_policy_name

  enable_secrets_manager_access             = var.enable_secrets_manager_access
  orca_security_secrets_manager_policy_name = var.orca_security_secrets_manager_policy_name

  tags = {
    "key" = "value
  }
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.47.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.47.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_orca_security_client_policy"></a> [orca\_security\_client\_policy](#module\_orca\_security\_client\_policy) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy | v5.2.0 |
| <a name="module_orca_security_in_account_client_to_scanner_policy"></a> [orca\_security\_in\_account\_client\_to\_scanner\_policy](#module\_orca\_security\_in\_account\_client\_to\_scanner\_policy) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy | v5.2.0 |
| <a name="module_orca_security_rds_snapshot_creation_policy"></a> [orca\_security\_rds\_snapshot\_creation\_policy](#module\_orca\_security\_rds\_snapshot\_creation\_policy) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy | v5.2.0 |
| <a name="module_orca_security_rds_snapshot_reencryption_policy"></a> [orca\_security\_rds\_snapshot\_reencryption\_policy](#module\_orca\_security\_rds\_snapshot\_reencryption\_policy) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy | v5.2.0 |
| <a name="module_orca_security_rds_snapshot_sharing_policy"></a> [orca\_security\_rds\_snapshot\_sharing\_policy](#module\_orca\_security\_rds\_snapshot\_sharing\_policy) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy | v5.2.0 |
| <a name="module_orca_security_role"></a> [orca\_security\_role](#module\_orca\_security\_role) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-assumable-role | v5.2.0 |
| <a name="module_orca_security_secrets_manager_policy"></a> [orca\_security\_secrets\_manager\_policy](#module\_orca\_security\_secrets\_manager\_policy) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy | v5.2.0 |
| <a name="module_orca_security_side_scanner_role"></a> [orca\_security\_side\_scanner\_role](#module\_orca\_security\_side\_scanner\_role) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-assumable-role | v5.2.0 |
| <a name="module_orca_security_view_only_extras_policy"></a> [orca\_security\_view\_only\_extras\_policy](#module\_orca\_security\_view\_only\_extras\_policy) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy | v5.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.orca_security_client_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.orca_security_in_account_client_to_scanner_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.orca_security_rds_snapshot_creation_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.orca_security_rds_snapshot_reencryption_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.orca_security_rds_snapshot_sharing_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.orca_security_secrets_manager_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.orca_security_view_only_extras_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_strategy"></a> [deployment\_strategy](#input\_deployment\_strategy) | Orca Security Deployment Strategy. | `string` | `"SaaS"` | no |
| <a name="input_enable_rds_access"></a> [enable\_rds\_access](#input\_enable\_rds\_access) | Whether to enable RDS Access to Orca Security or not. | `bool` | `true` | no |
| <a name="input_enable_secrets_manager_access"></a> [enable\_secrets\_manager\_access](#input\_enable\_secrets\_manager\_access) | Whether to enable Secrets Manager Access to Orca Security or not. | `bool` | `true` | no |
| <a name="input_external_id"></a> [external\_id](#input\_external\_id) | External ID provided by Orca Security. | `string` | n/a | yes |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | Path for IAM Roles and Policies | `string` | `"/"` | no |
| <a name="input_orca_security_client_policy_name"></a> [orca\_security\_client\_policy\_name](#input\_orca\_security\_client\_policy\_name) | Orca Security Client Policy Name. | `string` | `"OrcaSecurityPolicy"` | no |
| <a name="input_orca_security_in_account_client_to_scanner_policy_name"></a> [orca\_security\_in\_account\_client\_to\_scanner\_policy\_name](#input\_orca\_security\_in\_account\_client\_to\_scanner\_policy\_name) | Orca Security In Account Client to Scanner Policy Name. | `string` | `"OrcaSecuritySideScannerPolicy"` | no |
| <a name="input_orca_security_rds_snapshot_creation_policy_name"></a> [orca\_security\_rds\_snapshot\_creation\_policy\_name](#input\_orca\_security\_rds\_snapshot\_creation\_policy\_name) | Orca Security RDS Snapshot Creation Policy Name. | `string` | `"OrcaSecurityRDSSnapshotCreationPolicy"` | no |
| <a name="input_orca_security_rds_snapshot_reencryption_policy_name"></a> [orca\_security\_rds\_snapshot\_reencryption\_policy\_name](#input\_orca\_security\_rds\_snapshot\_reencryption\_policy\_name) | Orca Security RDS Snapshot Re-Encryption Policy Name. | `string` | `"OrcaSecurityRDSSnapshotReEncryptionPolicy"` | no |
| <a name="input_orca_security_rds_snapshot_sharing_policy_name"></a> [orca\_security\_rds\_snapshot\_sharing\_policy\_name](#input\_orca\_security\_rds\_snapshot\_sharing\_policy\_name) | Orca Security RDS Snapshot Sharing Policy Name. | `string` | `"OrcaSecurityRDSSnapshotSharingPolicy"` | no |
| <a name="input_orca_security_role_description"></a> [orca\_security\_role\_description](#input\_orca\_security\_role\_description) | Orca Security Role Description. | `string` | `"Orca Security Role"` | no |
| <a name="input_orca_security_role_name"></a> [orca\_security\_role\_name](#input\_orca\_security\_role\_name) | Orca Security Role Name. | `string` | `"OrcaSecurityRole"` | no |
| <a name="input_orca_security_secrets_manager_policy_name"></a> [orca\_security\_secrets\_manager\_policy\_name](#input\_orca\_security\_secrets\_manager\_policy\_name) | Orca Security Secrets Manager Policy Name. | `string` | `"OrcaSecuritySecretsManagerPolicy"` | no |
| <a name="input_orca_security_side_scanner_role_description"></a> [orca\_security\_side\_scanner\_role\_description](#input\_orca\_security\_side\_scanner\_role\_description) | Orca Security Side Scanner Role Description. | `string` | `"Orca Side Scanner Role"` | no |
| <a name="input_orca_security_side_scanner_role_name"></a> [orca\_security\_side\_scanner\_role\_name](#input\_orca\_security\_side\_scanner\_role\_name) | Orca Security Side Scanner Role Name. | `string` | `"OrcaSideScannerRole"` | no |
| <a name="input_orca_security_view_only_extras_policy_name"></a> [orca\_security\_view\_only\_extras\_policy\_name](#input\_orca\_security\_view\_only\_extras\_policy\_name) | Orca Security View only Extras Client Policy Name. | `string` | `"OrcaSecurityExtrasForViewOnlyPolicy"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Mandatory normalized tags to tag the resources accordingly. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_orca_security_role_arn"></a> [orca\_security\_role\_arn](#output\_orca\_security\_role\_arn) | Orca Security Role ARN |
| <a name="output_orca_security_side_scanner_role_arn"></a> [orca\_security\_side\_scanner\_role\_arn](#output\_orca\_security\_side\_scanner\_role\_arn) | Orca Security Side Scanner Role ARN |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
