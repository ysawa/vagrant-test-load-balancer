class nginx::config::default {

  file { '/etc/nginx/conf.d/default.conf':
    require => [
      Package['nginx'],
      Exec['replace /etc/nginx/nginx.conf'],
    ],
    ensure  => file,
    source  => 'puppet:///modules/nginx/conf.d/default.conf',
    replace => no,
    mode    => 0644,
    owner   => www-data,
    group   => www-data,
  }

  exec { 'reload nginx after uploading default.conf':
    require => [
      Service['nginx'],
      File['/etc/nginx/conf.d/default.conf'],
    ],
    command => '/etc/init.d/nginx reload',
  }
}
