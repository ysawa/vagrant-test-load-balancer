class mongodb {

  file { '/tmp/puppet_mongodb_install.sh':
    ensure  => 'file',
    source  => 'puppet:///modules/mongodb/install.sh',
    mode    => '0777',
    owner   => root,
    group   => root,
  }

  file { '/tmp/mongodb.conf':
    require => [
      File['/tmp/puppet_mongodb_install.sh'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/mongodb/mongodb.conf',
    # replace => 'no',
    mode    => '0644',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet_mongodb_install.sh":
    require => [
      File['/tmp/mongodb.conf'],
    ],
    cwd       => '/tmp/',
    unless => '/bin/ls /usr/bin/mongod', # TODO make condition more specifically
  }
}
