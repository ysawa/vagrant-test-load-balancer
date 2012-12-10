class nginx::install {

  $apache_packages = ['apache2', 'apache2.2-bin', 'apache2.2-common']
  package { $apache_packages: ensure => "absent" }

  package { 'fcgiwrap':
    ensure => installed,
  }
  service { 'fcgiwrap':
    require => [
      Package['fcgiwrap'],
    ],
    ensure => running,
  }

  $packages = ['nginx']
  package { $packages:
    require => [
      Class['php5::install'],
      Class['ppa::repositories::nginx-stable'],
      Package['fcgiwrap'],
      Service['fcgiwrap'],
    ],
    ensure => installed
  }

  file { '/etc/nginx/nginx.conf.puppet':
    require => [
      Package['nginx'],
    ],
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    mode    => 0644,
    owner   => www-data,
    group   => www-data,
  }

  exec { 'replace /etc/nginx/nginx.conf':
    require => [
      File['/etc/nginx/nginx.conf.puppet'],
      Package['nginx'],
    ],
    command => '/bin/mv /etc/nginx/nginx.conf.puppet /etc/nginx/nginx.conf',
    unless => '/usr/bin/test `/bin/cat /etc/nginx/nginx.conf | /bin/grep -c "USED BY PUPPET$"` -ne 0',
  }

  file { '/var/www/index.html':
    require => [
      Exec['replace /etc/nginx/nginx.conf'],
    ],
    ensure  => file,
    source  => 'puppet:///modules/nginx/www/index.html',
    replace => no,
    mode    => 0644,
    owner   => www-data,
    group   => www-data,
  }

  file { '/var/www/50x.html':
    require => [
      Exec['replace /etc/nginx/nginx.conf'],
    ],
    ensure  => file,
    source  => 'puppet:///modules/nginx/www/50x.html',
    replace => no,
    mode    => 0644,
    owner   => www-data,
    group   => www-data,
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
    ensure => running,
  }
}
