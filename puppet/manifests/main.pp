exec { 'apt-get update': command => '/usr/bin/apt-get update -y', }
# package { 'nginx': ensure => present, require => Exec['apt-get update'], }

$essentials = ["build-essential", "libxslt1.1", "libxslt1-dev", "libxml2", "libssl-dev", "libcurl4-openssl-dev", "git-core", "libffi-dev", "libsqlite3-dev", "libpq-dev", "libreadline5-dev", "sysv-rc-conf"]
package { $essentials: ensure => "installed" }

include nginx
include mongodb
