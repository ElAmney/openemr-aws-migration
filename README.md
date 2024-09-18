# OpenEMR AWS Migration

## Overview

This repository provides a comprehensive solution for migrating a local OpenEMR server to AWS using either AWS CloudFormation or Terraform as well as a guided Bash script for smooth setup and installation. By automating the resource provisioning and setup, this tool simplifies the process of hosting OpenEMR on AWS, allowing for improved scalability, security, and reliability.

## Prerequisites

Before using this tool, ensure that you have the following:

- An AWS account with sufficient permissions to create resources.
- AWS CLI configured on your local machine.
- Access to your existing OpenEMR database and files.
- (Optional) A domain name if you wish to configure OpenEMR to a specific domain.

## Technologies

- **Terraform/CloudFormation:** For provisioning the necessary resources in the cloud.
- **Bash/Shell:** To provide a guided installation that would configure resources based on user needs.

## Goals

- **Validating my knowledge:** Demonstrate proficiency in migrating local infrastructure to the cloud.
- **Familiarizing myself with healthcare infrastructure:** Learn more about the healthcare standards for building medical infrastructure (i.e HIPAA, FHIR, HL7, etc.).

## Milestones

- ~~**Phase 1: Initial setup**~~ **[COMPLETE]**
  - ~~Set up a basic openEMR server locally + familiarize myself with the architecture.~~

- **Phase 2: Writing the CloudFormation IaC template** **[IN PROGRESS]**
  - Create a CloudFormation template for a standard setup.
  - Update `migration.sh` to interactively update the template based on user configurations.

- **Phase 3: Convert the CF template to a Terraform template** **[NOT STARTED]**
  - Create a Terraform template for AWS migration.
  - Update `migration.sh` for a terraform provision instead.

## Installation & Configuration

## References

- [OpenEMR](https://www.open-emr.org/) + [GitHub Repo](https://github.com/openemr/openemr)
- [OpenEMR products in AWS Marketplace](https://aws.amazon.com/marketplace/seller-profile?id=bec33905-edcb-4c30-b3ae-e2960a9a5ef4&ref=dtl_B07BBT4C1H)
