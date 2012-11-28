class nginx {

  package { ['apache2']: ensure => "absent" }
  package { ['libpcre3', 'libpcre3-dev']: ensure => "installed" }

  file { '/tmp/puppet-install-nginx.sh':
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/install.sh',
    mode    => '0777',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet-install-nginx.sh":
    require => [
      File['/tmp/puppet-install-nginx.sh'],
    ],
    cwd       => '/tmp/',
    unless => '/bin/ls /usr/local/nginx/sbin/nginx', # TODO make condition more specifically
  }

  file { '/etc/nginx/conf.d':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'nginx',
    group   => 'nginx',
  }

  file { '/var/run/nginx':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'nginx',
    group   => 'nginx',
  }

  file { '/var/log/nginx':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'nginx',
    group   => 'nginx',
  }

  file { '/var/tmp/nginx':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'nginx',
    group   => 'nginx',
  }
}
