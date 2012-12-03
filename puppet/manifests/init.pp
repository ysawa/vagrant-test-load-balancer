
node default {
  exec { 'apt-get update': command => '/usr/bin/apt-get update -y', }
  include ppa
  include essentials
  include php5
  include nginx
  include mongodb
  include graphicsmagick
  include redis
  include mongodb::replication
  include hosts
  include editors
  include nagios
  # include ganglia
  include munin::node
}

node m0 inherits default {
  include munin
}

node m1 inherits default {
}

node m2 inherits default {
}

node m3 inherits default {
}
