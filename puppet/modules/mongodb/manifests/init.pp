class mongodb {

  file { '/tmp/puppet_mongodb_install.sh':
    ensure  => 'file',
    source  => 'puppet:///modules/mongodb/install.sh',
    mode    => '0777',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet_mongodb_install.sh":
    require => [
      File['/tmp/puppet_mongodb_install.sh'],
    ],
    cwd       => '/tmp/',
    # unless => '/bin/ls /usr/local/bin/mongod', # TODO make condition more specifically
  }

  exec { 'apt-get update for mongodb-10gen':
    require => [
      Exec['/tmp/puppet_mongodb_install.sh'],
    ],
    command => '/usr/bin/apt-get update -y',
  }

  package { ['mongodb-10gen']:
    require => [
      Exec['apt-get update for mongodb-10gen'],
    ],
    ensure => 'installed',
  }

  exec { 'sysv-rc-conf mongodb on':
    require => [
      Package['mongodb-10gen'],
    ],
    command => '/usr/sbin/sysv-rc-conf mongodb on',
  }
}
