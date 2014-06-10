# Deploy the exercise web page from git
class site::roles::website {
  vcsrepo { '/var/www/example.com':
      ensure   => latest,
      provider => git,
      source   => 'git://github.com/puppetlabs/exercise-webpage.git',
      revision => 'master',
      require  => File['/var/www'],
  }
}
