class nginx {

  $apache_packages = ['apache2', 'apache2.2-bin', 'apache2.2-common']
  package { $apache_packages: ensure => "absent" }

  package { 'fcgiwrap':
    ensure => 'installed',
  }
  service { 'fcgiwrap':
    require => [
      Package['fcgiwrap'],
    ],
    ensure => 'running',
  }

  $packages = ['nginx']
  package { $packages:
    require => [
      Package['fcgiwrap'],
      Service['fcgiwrap'],
    ],
    ensure => 'installed'
  }

  file { '/tmp/puppet-nginx.conf':
    require => [
      Package['nginx'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/nginx.conf',
    # replace => 'no', # TODO should replace only the first time
    mode    => '0644',
    owner   => 'www-data',
    group   => 'www-data',
  }

  exec { 'replace /etc/nginx/nginx.conf':
    require => [
      Package['nginx'],
      # Exec['chown nginx directories'],
    ],
    command => '/bin/mv /tmp/puppet-nginx.conf /etc/nginx/nginx.conf',
    unless => '/usr/bin/test `cat /etc/nginx/nginx.conf | grep -c "PLACED BY PUPPET"$` -ne 0',
  }

  file { '/var/www/index.html':
    require => [
      Exec['replace /etc/nginx/nginx.conf'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/www/index.html',
    replace => 'no',
    mode    => '0644',
    owner   => 'www-data',
    group   => 'www-data',
  }

  file { '/var/www/50x.html':
    require => [
      Exec['replace /etc/nginx/nginx.conf'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/www/50x.html',
    replace => 'no',
    mode    => '0644',
    owner   => 'www-data',
    group   => 'www-data',
  }

  ssl::cert { 'nginx':
  }

  service { 'nginx':
    require => [
      Package['nginx'],
      Ssl::Cert['nginx'],
      Package['php5-fpm'],
      Exec['replace /etc/nginx/nginx.conf'],
    ],
    ensure => 'running',
  }
}
