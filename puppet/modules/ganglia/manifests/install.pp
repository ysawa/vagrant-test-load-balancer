class ganglia::install {

  $packages = ['rrdtool', 'ganglia-monitor', 'ganglia-webfrontend']
  package { $packages:
    require => [
      Package['fcgiwrap'],
      Service['fcgiwrap'],
    ],
    ensure => installed,
  }

  $nginx_directories = ['/var/log/nginx/ganglia-webfrontend']
  file { $nginx_directories:
    require => [
      Package['nginx'],
      Package[$packages],
    ],
    ensure  => directory,
    mode    => 0755,
    owner   => www-data,
    group   => www-data,
  }

  file { '/etc/nginx/conf.d/ganglia-webfrontend.conf':
    require => [
      Package['nginx'],
      Package[$packages],
    ],
    ensure  => directory,
    replace => no,
    source  => 'puppet:///modules/ganglia/nginx.conf',
    mode    => 0644,
    owner   => www-data,
    group   => www-data,
  }

  $services = ['ganglia-monitor', 'gmetad']
  service { $services:
    require => [
      Package[$packages],
    ],
    ensure => running,
  }

  exec { 'reload nginx after installing ganglia':
    require => [
      Service['nginx'],
      Service[$services],
    ],
    command => '/etc/init.d/nginx reload',
  }
}
