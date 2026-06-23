# 1.0.0 (2026-06-23)


### Bug Fixes

* **alexa-developer:** Add missing serverlessrepo permissions ([fb908e5](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/fb908e5d602fd7851b814d36e3bdc6aaa69e9632))
* cicd ([a2a07e7](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/a2a07e7177faf08363a4025fa308ac2878fd4150))
* **cloudtrail:** modify cloudtrail policy to allow creating of trails ([a6fb82b](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/a6fb82b709e889a1b857506977e4aad560e9e38b))
* fmt ([cafb791](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/cafb7911bf53cb982c76cce8092d200fac40ea36))
* Move "version" to proper place in data "aws_iam_policy_document" ([75978a4](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/75978a426c3fab81e914acb5ab39dbf55dd7eecd))
* **output:** Add newly added role "AlexaDeveloper" to output values ([fb10f12](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/fb10f1245cbd9a336889a587e3ca0025b061122b))
* **output:** Properly list created role names ([d52f9c2](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/d52f9c254f5d28fd767f4c46ba7cc525d462aadf))
* **policy:** Fixed changed Lambda policy arn ([d0039e9](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/d0039e98d14c8f6637317dd64be96fccec7e3516))
* Rename "action" to "actions" in data "aws_iam_policy_document" ([d886eac](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/d886eacdb9401d5706eef50720bdf4e5c6d07102))
* Use data "aws_iam_policy_document" to create IAM assume role policy in json ([8406cac](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/8406cac7f4a5f91808b61ef6ef98916543697817))


### Features

* Add ability to choose which roles should be provided ([e0df5ab](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/e0df5ab978ce956fd809eb6823b8c60d24c931c1))
* Add optional prefixes to created IAM roles and policies ([6800c6e](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/6800c6e31297fa32fe680bfd769c9dd4f86992ce))
* Add variable "roles_max_session_duration" used to manage max session duration ([461a139](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/461a139e027b4eeac1516fc4a885e0a26f67bac9))
* Added terraform access principals ([4ed360b](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/4ed360b8af4614329cb1007a4640d0ba3725541e))
* Added trusted roles ([64d49ca](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/64d49cae625fbf0bb8261a106fb206f19fcb4f29))
* **alexa-developer:** Add CloudFormation and IAM Role permissions to AlexaDeveloper role ([2d32689](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/2d326894b7e516f71910d4e799008e3071929001))
* **alexa-developer:** Add ServerLessRepo read only access ([dfa8982](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/dfa8982e0248612ecce240589d54c49d6c018961))
* Allow configuring MFA and ExternalID options ([59682ca](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/59682ca9e56318466b2cdf49875bb4c0c97af682))
* **aws:** Allow only HTTPS communication ([b0512d7](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/b0512d7b6afdf3c1843b0544c88342f35d76d7a5)), closes [#2](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/issues/2)
* **iam-role:** Add "SuperAdministratorAccess" to allow managing CloudTrail ([041d3bc](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/041d3bc6f59d504c5a8e55ce5d04022186fbbc6d))
* Initialize module ([fbd52a4](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/fbd52a46fda244a85d4f5379f404ef241e69309b))
* More granular approach to trust entities ([2c7031f](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/2c7031f2161651ff8630e0c7d95b0c3b44ab5812))
* **principals:** Allow defining multiple principals ([aa5b258](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/aa5b25874d47f614ed0ced54863fdb5758609f6b))
* **provider:** lock AWS provider to version 3.x ([3e8513c](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/3e8513ca28ca49b8ef5d0db35dcfcd520242eb6b))
* Remove DenyCloudTrail role ([7c2148e](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/7c2148e434920dcf75fc9d10b44ad38980bfe1d8))
* Rewrote Trust ([e105159](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/e1051594212cd59537f1f04a50f430e537039b53))
* **role:** Add "AlexaDeveloper" role ([ed0b0e0](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/ed0b0e046ed09432e6b628fac304bc5acfd55a7c))
* **role:** Add "Analyst" role with readonly access + Athena full access ([644606b](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/644606bf9a0598f293bb33f470acd0c91f5b816c))
* **roles:** added descriptions to roles created by module ([c3a640e](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/c3a640e69da91e3c74b8c3177ee9ca26be169d25))
* **terraform:** update to terraform 0.13.5 ([08a4d78](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/08a4d78552ce7ebe31e2613c405a385ca18e4621))
* Upgrade to terraform 0.12 syntax ([3cc6d19](https://gitlab.miquido.com/miquido/terraform/terraform-iam-roles/commit/3cc6d191b9f2550546da57cc621e56d5d1290fe3))


### BREAKING CHANGES

* **principals:** Variable "authentication_account_no" is replaced by "principals" variable which is
a list of AWS IAM principals.
