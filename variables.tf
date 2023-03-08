# General Configuration
variable "iam_path" {
  description = "Path for IAM Roles and Policies"
  type        = string
  default     = "/"
}
variable "external_id" {
  description = "External ID provided by Orca Security."
  type        = string
}

variable "deployment_strategy" {
  description = "Orca Security Deployment Strategy."
  type        = string
  validation {
    condition = contains(
      [
        "SaaS",
        "In-account"
    ], var.deployment_strategy)
    error_message = "The Orca Security Deployment Strategy value must be a valid value among the allowed values (\"SaaS\", \"In-account\")."
  }
}

# Roles Configuration
variable "orca_security_role_name" {
  description = "Orca Security Role Name."
  type        = string
  default     = "OrcaSecurityRole"
}
variable "orca_security_role_description" {
  description = "Orca Security Role Description."
  type        = string
  default     = "Orca Security Role"
}
variable "orca_security_side_scanner_role_name" {
  description = "Orca Security Side Scanner Role Name."
  type        = string
  default     = "OrcaSideScannerRole"
}
variable "orca_security_side_scanner_role_description" {
  description = "Orca Security Side Scanner Role Description."
  type        = string
  default     = "Orca Side Scanner Role"
}

# Policy Names
variable "orca_security_client_policy_name" {
  description = "Orca Security Client Policy Name."
  type        = string
  default     = "OrcaSecurityPolicy"
}

variable "orca_security_in_account_client_to_scanner_policy_name" {
  description = "Orca Security In Account Client to Scanner Policy Name."
  type        = string
  default     = "OrcaSecuritySideScannerPolicy"
}
variable "orca_security_view_only_extras_policy_name" {
  description = "Orca Security View only Extras Client Policy Name."
  type        = string
  default     = "OrcaSecurityExtrasForViewOnlyPolicy"
}

# RDS Configuration
variable "enable_rds_access" {
  description = "Whether to enable RDS Access to Orca Security or not."
  type        = bool
  default     = true
}

variable "orca_security_rds_snapshot_creation_policy_name" {
  description = "Orca Security RDS Snapshot Creation Policy Name."
  type        = string
  default     = "OrcaSecurityRDSSnapshotCreationPolicy"
}

variable "orca_security_rds_snapshot_reencryption_policy_name" {
  description = "Orca Security RDS Snapshot Re-Encryption Policy Name."
  type        = string
  default     = "OrcaSecurityRDSSnapshotReEncryptionPolicy"
}

variable "orca_security_rds_snapshot_sharing_policy_name" {
  description = "Orca Security RDS Snapshot Sharing Policy Name."
  type        = string
  default     = "OrcaSecurityRDSSnapshotSharingPolicy"
}

# Secrets Manager Configuration
variable "enable_secrets_manager_access" {
  description = "Whether to enable Secrets Manager Access to Orca Security or not."
  type        = bool
  default     = true
}

variable "orca_security_secrets_manager_policy_name" {
  description = "Orca Security Secrets Manager Policy Name."
  type        = string
  default     = "OrcaSecuritySecretsManagerPolicy"
}

# Tags
variable "tags" {
  description = "Mandatory normalized tags to tag the resources accordingly."
  type        = map(string)
}
