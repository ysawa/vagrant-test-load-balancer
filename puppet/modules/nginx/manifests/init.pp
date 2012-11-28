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

  file { '/var/lock/nginx':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'nginx',
    group   => 'nginx',
  }

  exec { 'chown nginx directories':
    command => '/bin/chown -R nginx:nginx /var/run/nginx /var/log/nginx /var/lock/nginx /var/tmp/nginx; true'
  }

  file { '/etc/init.d/nginx':
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/nginx.sh',
    # replace => 'no',
    mode    => '0777',
    owner   => root,
    group   => root,
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/nginx.conf',
    # replace => 'no',
    mode    => '0755',
    owner   => nginx,
    group   => nginx,
  }
}
