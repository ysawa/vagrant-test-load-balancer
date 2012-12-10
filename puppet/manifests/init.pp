
node default {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update -y',
  }
  exec { 'apt-get upgrade':
    require => [
      Exec['apt-get update'],
    ],
    command => '/usr/bin/apt-get upgrade -y',
  }
  include hosts
  include ppa
  include essentials
  include ssl
  include php5
  include nginx::install
  include graphicsmagick
  include redis
  include mongodb::install
  include editors
  include nagios
  include munin::node
  include dovecot
  include postfix
  include rvm
  # include ganglia
}

node /^web/ inherits default {
  include munin::install
  include nginx::config::cluster
}

node /^app/ inherits default {
  include mongodb::replication
  include nginx::config::default
  include ptetex3
  user { 'app':
    ensure => present,
    managehome => true,
  }
  rvm::user{ 'app': }
}
