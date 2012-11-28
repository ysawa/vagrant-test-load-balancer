exec { 'apt-get update': command => '/usr/bin/apt-get update -y', }
# package { 'nginx': ensure => present, require => Exec['apt-get update'], }

$essentials = ["build-essential", "libxslt1.1", "libxml2", "libssl-dev", "git-core", "libffi-dev", "libsqlite3-dev", "libreadline5-dev", "vim"]
package { $essentials:
  ensure => "installed"
}

include nginx
include mongodb
include graphicsmagick
