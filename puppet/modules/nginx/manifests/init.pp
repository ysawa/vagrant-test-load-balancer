class nginx {
  file { '/tmp/nginx.sh':
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/install.sh',
    mode    => '777',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/nginx.sh":
    require => [
      File['/tmp/nginx.sh'],
    ],
    refreshonly => true,
    cwd       => '/',
    path      => '/sbin/:/usr/bin/:/bin',
  }
}
