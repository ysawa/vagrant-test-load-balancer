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

  $redis_directories = ['/var/run/redis', '/var/lib/redis', '/var/log/redis', '/var/lock/redis', '/usr/local/redis']
  file { $redis_directories:
    require => [
      Exec["/tmp/puppet_redis_install.sh"],
    ],
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'redis',
    group   => 'redis',
  }

  exec { 'chown redis directories':
    require => [
      File[$redis_directories],
    ],
    command => '/bin/chown -R redis:redis /var/run/redis /var/lib/redis /var/log/redis /var/lock/redis; true',
  }

  file { '/etc/init.d/redis-server':
    require => [
      Exec['chown redis directories'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/redis/redis-server.sh',
    replace => 'no',
    mode    => '0777',
    owner   => root,
    group   => root,
  }

  file { '/etc/redis.conf':
    require => [
      Exec['chown redis directories'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/redis/redis.conf',
    # replace => 'no',
    mode    => '0644',
    owner   => redis,
    group   => redis,
  }

  file { '/etc/init/redis-server.conf':
    require => [
      File['/etc/redis.conf'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/redis/init/redis-server.conf',
    replace => 'no',
    mode    => '0644',
    owner   => root,
    group   => root,
  }

  exec { 'start redis-server':
    require => [
      File['/etc/init/redis-server.conf'],
    ],
    command => '/sbin/start redis-server',
  }
}
