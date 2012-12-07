class nginx::config::cluster {

  file { '/etc/nginx/conf.d/cluster.conf':
    require => [
      Package['nginx'],
      Exec['replace /etc/nginx/nginx.conf'],
    ],
    ensure  => file,
    source  => 'puppet:///modules/nginx/conf.d/cluster.conf',
    replace => no,
    mode    => 0644,
    owner   => www-data,
    group   => www-data,
  }

  exec { 'reload nginx after uploading cluster.conf':
    require => [
      Service['nginx'],
      File['/etc/nginx/conf.d/cluster.conf'],
    ],
    command => '/etc/init.d/nginx reload',
  }
}
