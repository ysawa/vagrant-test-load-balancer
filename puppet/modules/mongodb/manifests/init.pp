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
    unless => '/bin/ls /usr/local/bin/mongod', # TODO make condition more specifically
  }

  file { '/var/lib/mongo':
    ensure  => 'directory',
    mode    => '0777',
    owner   => 'mongo',
    group   => 'mongo',
  }

  file { '/etc/mongod.conf':
    ensure  => 'file',
    replace => 'no',
    source  => 'puppet:///modules/mongodb/mongod.conf',
    mode    => '0644',
    owner   => root,
    group   => root,
  }

  file { '/etc/init.d/mongod':
    ensure  => 'file',
    replace => 'no',
    source  => 'puppet:///modules/mongodb/mongod.sh',
    mode    => '0755',
    owner   => root,
    group   => root,
  }
}
