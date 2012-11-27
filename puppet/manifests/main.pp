file {'testfile':
  path => '/tmp/testfile',
  ensure => present,
  mode => 0640,
  content => "I'm a test file.",
}

exec { 'apt-get update': command => '/usr/bin/apt-get update -y', }
# package { 'nginx': ensure => present, require => Exec['apt-get update'], }

$essentials = ["build-essential", "libxslt1.1", "libxslt1-dev", "libxml2", "libssl-dev", "libcurl4-openssl-dev", "git-core", "libffi-dev", "libsqlite3-dev", "libpq-dev", "libreadline5-dev"]
package { $essentials: ensure => "installed" }

include nginx

