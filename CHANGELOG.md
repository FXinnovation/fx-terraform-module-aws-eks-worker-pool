
5.0.0 / 2021-09-01
==================

* (BREAKING) chore: pins pre-commit-hooks to v4.0.1.
* feat: add pre-commit-afcmf (v0.1.2).
* chore: pins pre-commit-terraform to v1.50.0.
* chore: pins terraform to >= 0.14.
* chore: pins aws provider to >= 3.0.
* chore: bumps terraform + providers versions in example:
  * pins terraform to >= 0.14.
  * pins aws provider to >= 3.0.
  * (BREAKING) pins random provider to >= 3.0.
* refactor: move providers in providers.tf file in examples.
* refactor: add versions.tf file in examples.
* doc: add README.md file in examples.
* refactor: get rid of disabled example.
* refactor: lint code in example test cases.
* refactor: lint code in root module.

4.0.0 / 2020-09-24
==================

  * maintenance: (BREAKING) Remove SG creation from this module (only attach existing ones)
  * chore: bump pre-commit hooks

3.0.0 / 2020-09-24
==================

  * maintenance: (BREAKING) Add versions.tf file
  * feat: Add asg metric collection options
  * chore: Update pre-commit configuration

2.1.0 / 2020-01-29
==================

  * feat: Allow for multiple worker pools

2.0.0 / 2020-03-02
==================

  * breaking: Add some block device options

1.4.0 / 2020-02-24
==================

  * fix/ tests
  * feat/ add dependencies

1.3.1 / 2020-01-28
==================

  * fix: bootstrap arguments position

1.3.0 / 2020-01-28
==================

  * feat: Add additional EKS bootstrap arguments

1.2.0 / 2020-01-16
==================

  * feature: Add spot-price variable and examples
  * run pre-commit
  * Add a way to execute custom commands before launching script bootstrap.sh

1.1.0 / 2019-11-13
==================

  * feat: Add output that will provide aws-auth data

1.0.0 / 2019-10-29
==================

  * Fix: changed string var to bool
  * feature: Use auto-discovery from AWS bootstrap script

0.3.0 / 2019-10-29
==================

  * feature: Add ability to set a key name on AWS LC

0.2.2 / 2019-10-29
==================

  * fix: Changed default variable for use_max_pods

0.2.1 / 2019-10-29
==================

  * fix: Allow for sg to talk on port 443 also

0.2.0 / 2019-10-29
==================

  * feature: Add intelligence in AMI selection

0.1.1 / 2019-10-28
==================

  * Fix another thing
  * Trying to fix terraform limitation

0.1.0 / 2019-10-25
==================

  * Fix: Allowing for empty list in allowed_cidr_blocks
  * Fix: Typo in variable name
  * Fix: Problem with datasource in example
  * fix: typo fixes eveywhere
  * feature: Add userdata template
  * feature: Add Jenkinsfile
  * feature: Intial import of files
  * doc: fill in readme
  * feature: fill in license file
  * feature: pre-commit config and execution fixes
  * Initial commit
