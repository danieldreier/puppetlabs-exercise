node default {
  class { '::site::roles::base': }
  class { '::site::roles::webserver': }
  class { '::site::roles::website': }
}
