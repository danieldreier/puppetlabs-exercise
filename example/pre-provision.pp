# Bootstrap librarian puppet

node default {
  # Install librarian-puppet
  package { 'rubygems': ensure => 'installed' }
  package { 'librarian-puppet':
    ensure   => 'installed',
    provider => 'gem',
    require  => Package['rubygems'],
  }

  file { '/etc/puppet/Puppetfile':
    mode   => '0644',
    source => '/vagrant/Puppetfile',
  }
  file { '/etc/hiera.yaml':
    mode   => '0644',
    source => '/vagrant/example/hiera.yaml',
  }
  file { '/etc/puppet/hiera.yaml':
    ensure => 'link',
    target => '/etc/hiera.yaml',
  }
  file { '/etc/puppet/puppet.conf':
    mode   => '0644',
    source => '/vagrant/example/puppet.conf',
  }

  # Run librarian-puppet only if Puppetfile changed
  exec { 'run librarian-puppet':
    environment => ['HOME=/root'],
    timeout     => '600',
    command     => 'librarian-puppet install',
    cwd         => '/etc/puppet',
    refreshonly => true,
    subscribe   => File['/etc/puppet/Puppetfile'],
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require     => [ File['/etc/puppet/Puppetfile'],
                    Package['librarian-puppet'], ],
  }
}
