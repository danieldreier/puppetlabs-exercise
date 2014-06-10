# Everything needed to set up a base webserver
# Wraps apache module, adds firewall
class site::roles::webserver (
  $vhosts = {},
  ) {

  class { 'nginx': }

  firewall { '102 allow http':
    port   => [8000],
    proto  => tcp,
    action => accept,
  }

  file { [ '/var/www' ]:
    ensure => 'directory',
  }

}


