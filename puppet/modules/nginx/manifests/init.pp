class nginx {

  package { ['apache2']: ensure => "absent" }

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

  file { '/etc/nginx/conf.d/default.conf':
    require => [
      Package['nginx'],
      File['/etc/nginx/nginx.conf'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/conf.d/default.conf',
    replace => 'no',
    mode    => '0644',
    owner   => 'www-data',
    group   => 'www-data',
  }

  service { 'nginx':
    require => [
      Package['nginx'],
      Package['php5-fpm'],
      File['/etc/nginx/conf.d/default.conf'],
    ],
    ensure => 'running',
  }
}
