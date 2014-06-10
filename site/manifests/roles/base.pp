# The base role is for basic configuration common to all servers
# Wraps other packages to avoid having to redefine these for each node
class site::roles::base (
  $timezone = 'America/Los_Angeles',
  ) {
  class { '::site::roles::base::packages': }
  class { '::site::roles::firewall': }
  class { 'timezone': timezone => $timezone }
}
