class munin::install {

  $packages = ['munin']
  package { $packages:
    require => [
      Package['fcgiwrap'],
      Package['apache2', 'apache2.2-bin', 'apache2.2-common'],
      Service['fcgiwrap'],
    ],
    ensure => installed,
  }

  $nginx_directories = ['/var/log/nginx/munin']
  file { $nginx_directories:
    require => [
      Class['nginx::install'],
      Package['munin'],
    ],
    ensure  => directory,
    mode    => 0755,
    owner   => www-data,
    group   => www-data,
  }

  file { '/etc/munin/munin.conf.puppet':
    require => [
      Package[$packages],
    ],
    ensure  => file,
    content => template("munin/munin.conf.erb"),
    mode    => 0644,
    owner   => root,
    group   => root,
  }

  exec { 'replace /etc/munin/munin.conf':
    require => [
      File['/etc/munin/munin.conf.puppet'],
      Package[$packages],
    ],
    command => '/bin/mv /etc/munin/munin.conf.puppet /etc/munin/munin.conf',
    unless => '/usr/bin/test `/bin/cat /etc/munin/munin.conf | /bin/grep -c "USED BY PUPPET$"` -ne 0',
  }

  file { '/etc/nginx/conf.d/munin.conf':
    require => [
      Package['munin'],
      Class['nginx::install'],
    ],
    ensure  => file,
    replace => no,
    source  => 'puppet:///modules/munin/nginx.conf',
    mode    => 0644,
    owner   => www-data,
    group   => www-data,
  }

  exec { 'reload nginx after installing munin':
    require => [
      Class['nginx::install'],
      File['/etc/nginx/conf.d/munin.conf'],
    ],
    command => '/etc/init.d/nginx reload',
  }
}
