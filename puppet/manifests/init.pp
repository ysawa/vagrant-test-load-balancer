
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
  include fonts
  include ppa
  include essentials
  include logrotate
  include ssl
  include php5
  include nginx::install
  include graphicsmagick
  include redis
  include mongodb::install
  include vim
  include emacs
  include nagios
  include munin::node
  include dovecot
  include postfix
  include rvm
  # include ganglia

  ssl::cert { 'server':
  }
}

node /^web/ inherits default {
  include munin::install
  include nginx::config::cluster
}

node /^app/ inherits default {
  include mongodb::replicaset

  mongodb::replicaset::initiate { 'set01':
    host => [
      "192.168.3.10:27017",
      "192.168.3.11:27017",
      "192.168.3.12:27017",
    ]
  }

  include nginx::config::default
  include ptetex3
  user { 'app':
    ensure => present,
    managehome => true,
  }
  rvm::user{ 'app': }
}
