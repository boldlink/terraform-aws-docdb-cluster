# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [Unreleased]
- Feature: DocDB Global cluster.
- Fix `Ensure DocDB has audit logs enabled`.

## [1.2.1] - 2023-08-14
- fix: Updated vpc version in supporting resources to resolve pre-commit alert for deprecated arguments

## [1.2.0] - 2022-08-13
- Feat: Added supporting resource (VPC) to be used by all examples
- Added a makefile in each example to be used in the case of a single example deployment.

## [1.1.0] - 2022-06-24
- Refactored Examples (complete and minimum)
- Added VPC in examples
- Added Standard template files
- Fixed security `vpc_security_group_ids`
- Modified tags variable
- Modified resource names to ensure uniformity in stack naming
- Conflict fix in both identity and identity prefix


## [1.0.2] - 2022-03-22
- Fix: Example source link updated

## [1.0.1] - 2022-03-22
- Feature: Document db cluster Instance
- Feature: DocumentDB SubnetGroup
- Feature/fix

## [1.0.0] - YYYY-MM-DD
### Description
- Feature: DocumentDB cluster
- Added: DocumentDB example
- Feature/fix

[Unreleased]: https://github.com/boldlink/terraform-aws-docdb/compare/1.2.1...HEAD

[1.2.1]: https://github.com/boldlink/terraform-aws-docdb/releases/tag/1.2.1
[1.2.0]: https://github.com/boldlink/terraform-aws-docdb/releases/tag/1.2.0
[1.1.0]: https://github.com/boldlink/terraform-aws-docdb/releases/tag/1.1.0
[1.0.2]: https://github.com/boldlink/terraform-aws-docdb/releases/tag/1.0.2
[1.0.1]: https://github.com/boldlink/terraform-aws-docdb/releases/tag/1.0.1
[1.0.0]: https://github.com/boldlink/terraform-aws-docdb/releases/tag/1.0.0
