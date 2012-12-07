
node default {
  exec { 'apt-get update': command => '/usr/bin/apt-get update -y', }
  include hosts
  include ppa
  include essentials
  include ssl
  include php5
  include nginx::install
  include graphicsmagick
  include redis
  include mongodb
  include editors
  include nagios
  include munin::node
  include dovecot
  include postfix
  # include ganglia
}

node /^web/ inherits default {
  include munin
  include nginx::config::cluster
}

node /^app/ inherits default {
  include mongodb::replication
  include nginx::config::default
  include ptetex3
}
