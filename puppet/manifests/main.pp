exec { 'apt-get update': command => '/usr/bin/apt-get update -y', }
# package { 'nginx': ensure => present, require => Exec['apt-get update'], }

include essentials
include nginx
include mongodb
include graphicsmagick
include redis
include mongodb::replication
include hosts
