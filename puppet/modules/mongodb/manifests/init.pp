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
    unless => '/bin/ls /usr/bin/mongod', # TODO make condition more specifically
  }

  exec { 'sysv-rc-conf mongodb on':
    require => [
      Exec["/tmp/puppet_mongodb_install.sh"],
    ],
    command => '/usr/sbin/sysv-rc-conf mongodb on',
  }
}
