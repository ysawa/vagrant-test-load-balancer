class nginx::config::default {

  file { '/etc/nginx/conf.d/default.conf':
    require => [
      Class['nginx::install'],
    ],
    ensure  => file,
    content => template("nginx/conf.d/default.conf.erb"),
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
