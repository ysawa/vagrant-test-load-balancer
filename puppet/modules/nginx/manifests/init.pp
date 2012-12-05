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
      # Exec['chown nginx directories'],
    ],
    ensure => 'installed'
  }

  file { '/etc/nginx/nginx.conf':
    require => [
      Package['nginx'],
      # Exec['chown nginx directories'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/nginx.conf',
    # replace => 'no',
    mode    => '0644',
    owner   => 'www-data',
    group   => 'www-data',
  }

  file { '/var/www/index.html':
    require => [
      File['/etc/nginx/nginx.conf'],
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
      File['/etc/nginx/nginx.conf'],
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
      File['/etc/nginx/nginx.conf'],
    ],
    ensure => 'running',
  }
}
