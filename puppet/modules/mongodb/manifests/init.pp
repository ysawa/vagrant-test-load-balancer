class mongodb {

  file { '/tmp/mongodb.sh':
    ensure  => 'file',
    source  => 'puppet:///modules/mongodb/install.sh',
    mode    => '777',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/mongodb.sh":
    require => [
      File['/tmp/mongodb.sh'],
    ],
    cwd       => '/tmp/',
  }
}
