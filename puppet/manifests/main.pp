file {'testfile':
  path => '/tmp/testfile',
  ensure => present,
  mode => 0640,
  content => "I'm a test file.",
}

exec { 'apt-get update': command => '/usr/bin/apt-get update -y', }
# package { 'nginx': ensure => present, require => Exec['apt-get update'], }
