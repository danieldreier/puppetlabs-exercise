Puppet Labs Exercise Solution
=============================

####Table of Contents

1. [Description](#module-description)
2. [Usage](#usage)
3. [Testing](#testing)

##Module Description
This repository implements a basic puppet solution to a puppetlabs exercise.
The module wraps several other modules. It configures an nginx web server to
listen on port 8000 and downloads a git repository to serve as content.

The module is based on a template from https://github.com/garethr/puppet-module-skeleton.

##Usage
To experiment with this module, start it in vagrant with `vagrant up`.

No puppet server is needed - the module is designed to run in standalone puppet
with no exported resources. This module expects configuration data to be
configured via hiera yaml files in the hieradata folder.

##Testing

### Beaker Testing
Beaker runs puppet code in a virtual machine, then tests the resulting environment. The tests are in spec/acceptance/.
If you're using RVM for ruby gem management, here's how you set up to run acceptance tests:
```
rvm gemset create puppetlabs-exercise
rvm gemset use puppetlabs-exercise
bundle install
```

To actually run the tests, simply run `bundle exec rake acceptance`. You can may want to run one of these variants:
```
# Don't destroy the vagrant VM after provisioning, but do provision a new one each run
# This will allow you to inspect the VM afterward; by default the VM is destroyed at the end of the run
BEAKER_destroy=no BEAKER_provision=yes bundle exec rake acceptance

# If you already have a running VM (from the previous command, say) use the following to
# re-run provisioning and tests against the existing VM, to save a few minutes of VM boot time.
BEAKER_destroy=no BEAKER_provision=no bundle exec rake acceptance

# Run the tets against the Debian 7.3 image instead of the default Ubuntu 12.04
BEAKER_set=debian-73-x64 bundle exec rake acceptance

# All the above combined: run tests on a debian 7.3 image and leave the resulting box running
# so you can log in and see what went wrong
BEAKER_set=debian-73-x64 BEAKER_destroy=no BEAKER_provision=yes bundle exec rake acceptance
```

To log in to a VM that results from this:
```bash
find -name Vagrantfile
./.vagrant/beaker_vagrant_files/default.yml/Vagrantfile
cd .vagrant/beaker_vagrant_files/default.yml/
vagrant ssh
```

### Linting tools
Linting tools check basic syntax. This will test whether manifests compile,
yaml syntax, and erb template syntax.

This repository is configured to run a set of
linting tools when you run:
`bundle exec rake lint`
