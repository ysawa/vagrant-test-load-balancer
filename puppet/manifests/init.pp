
node default {
  exec { 'apt-get update': command => '/usr/bin/apt-get update -y', }
  include hosts
  include ppa
  include essentials
  include php5
  include nginx
  include graphicsmagick
  include redis
  include mongodb
  include editors
  include nagios
  include munin::node
  include ssl
  # include ganglia
}

node m0 inherits default {
  include munin
  include nginx::config::cluster
}

node m1, m2, m3 inherits default {
  include mongodb::replication
  include nginx::config::default
}
