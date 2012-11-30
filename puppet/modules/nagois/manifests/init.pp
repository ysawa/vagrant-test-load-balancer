class nagois {

  group { 'nagois':
    ensure => present,
  }

  user { 'bar':
    ensure => present,
    groups => ['nagois'],
    managehome => false,
    shell => '/usr/sbin/nologin',
    require => Group['nagois'],
*
  }

  file { '/tmp/puppet_nagois_install.sh':
    ensure  => 'file',
    source  => 'puppet:///modules/nagois/install.sh',
    mode    => '0700',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet_nagois_install.sh":
    require => [
    ],
    cwd       => '/tmp/',
    # unless => '/bin/ls /usr/bin/mongod', # TODO make condition more specifically
  }

}
