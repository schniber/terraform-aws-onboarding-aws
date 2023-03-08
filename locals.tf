locals {
  orca_vendor_account_id              = "976280145156"
  view_only_access_managed_policy_arn = format("arn:%s:iam::aws:policy/job-function/ViewOnlyAccess", data.aws_partition.current.partition)
  read_only_access_managed_policy_arn = format("arn:%s:iam::aws:policy/ReadOnlyAccess", data.aws_partition.current.partition)
}
