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

  service { 'nginx':
    require => [
      Package['nginx'],
      Package['php5-fpm'],
      File['/etc/nginx/nginx.conf'],
    ],
    ensure => 'running',
  }
}
