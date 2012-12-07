class mongodb::install {

  file { '/tmp/puppet_mongodb_install.sh':
    ensure  => file,
    source  => 'puppet:///modules/mongodb/install.sh',
    mode    => 0777,
    owner   => root,
    group   => root,
  }

  # put conf file into /tmp
  # in order to move it into /etc after installation
  file { '/tmp/mongodb.conf':
    require => [
      File['/tmp/puppet_mongodb_install.sh'],
    ],
    ensure  => file,
    source  => 'puppet:///modules/mongodb/mongodb.conf',
    replace => no,
    mode    => 0644,
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

  file { '/etc/mongodb.conf':
    require => [
      Exec["/tmp/puppet_mongodb_install.sh"],
    ],
    ensure  => file,
    source  => 'puppet:///modules/mongodb/mongodb.conf',
    replace => no,
    mode    => 0644,
    owner   => mongodb,
    group   => mongodb,
  }

  exec { 'restart mongodb':
    require => [
      File['/etc/mongodb.conf'],
    ],
    command => '/sbin/restart mongodb',
  }
}
