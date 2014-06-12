# Bootstrap r10k

package { 'rubygems': ensure => 'installed' }
package { 'r10k':
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
exec { 'run r10k':
  environment => ['HOME=/root'],
  timeout     => '600',
  command     => 'r10k puppetfile install',
  cwd         => '/etc/puppet',
  refreshonly => true,
  subscribe   => File['/etc/puppet/Puppetfile'],
  path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  require     => [ File['/etc/puppet/Puppetfile'],
                  Package['r10k'], ],
}
