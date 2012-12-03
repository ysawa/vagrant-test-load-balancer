
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
  include mongodb::replication
  include editors
  include nagios
  # include ganglia
  include munin::node
}

node m0 inherits default {
  include munin
}

node m1, m2, m3 inherits default {
}
