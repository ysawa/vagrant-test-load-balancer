class redis {

  file { '/tmp/puppet_redis_install.sh':
    ensure  => 'file',
    source  => 'puppet:///modules/redis/install.sh',
    mode    => '0777',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet_redis_install.sh":
    require => [
      File['/tmp/puppet_redis_install.sh'],
    ],
    cwd       => '/tmp/',
    unless => '/bin/ls /usr/local/bin/redis-server', # TODO make condition more specifically
  }
}
