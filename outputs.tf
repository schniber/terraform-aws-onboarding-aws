output "orca_security_role_arn" {
  description = "Orca Security Role ARN"
  value       = module.orca_security_role.iam_role_arn
}

output "orca_security_side_scanner_role_arn" {
  description = "Orca Security Side Scanner Role ARN"
  value       = module.orca_security_side_scanner_role.iam_role_arn
}
