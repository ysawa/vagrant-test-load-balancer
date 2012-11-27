class nginx {

  package { ['libpcre3', 'libpcre3-dev']: ensure => "installed" }

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
    cwd       => '/tmp/',
  }
}
