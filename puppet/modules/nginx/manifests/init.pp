class nginx {

  package { ['apache2']: ensure => "absent" }
  package { ['libpcre3', 'libpcre3-dev']: ensure => "installed" }

  file { '/tmp/puppet_nginx_install.sh':
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/install.sh',
    mode    => '0777',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet_nginx_install.sh":
    require => [
      File['/tmp/puppet_nginx_install.sh'],
      Package['libpcre3', 'libpcre3-dev'],
    ],
    cwd       => '/tmp/',
    unless => '/bin/ls /usr/local/nginx/sbin/nginx', # TODO make condition more specifically
  }

  $nginx_directories = ['/etc/nginx', '/etc/nginx/conf.d', '/var/run/nginx', '/var/lib/nginx', '/var/log/nginx', '/var/tmp/nginx', '/var/lock/nginx', '/usr/local/nginx']
  file { $nginx_directories:
    require => [
      Exec["/tmp/puppet_nginx_install.sh"],
    ],
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'nginx',
    group   => 'nginx',
  }

  exec { 'chown nginx directories':
    require => [
      File[$nginx_directories],
    ],
    command => '/bin/chown -R nginx:nginx /etc/nginx/conf.d /var/run/nginx /var/lib/nginx /var/log/nginx /var/lock/nginx /var/tmp/nginx; true',
  }

  file { '/etc/init.d/nginx':
    require => [
      Exec['chown nginx directories'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/nginx.sh',
    replace => 'no',
    mode    => '0777',
    owner   => root,
    group   => root,
  }

  file { '/etc/nginx/nginx.conf':
    require => [
      Exec['chown nginx directories'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/nginx.conf',
    replace => 'no',
    mode    => '0644',
    owner   => nginx,
    group   => nginx,
  }

  file { '/etc/nginx/conf.d/default.conf':
    require => [
      File['/etc/nginx/nginx.conf'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/conf.d/default.conf',
    replace => 'no',
    mode    => '0644',
    owner   => nginx,
    group   => nginx,
  }

  file { '/etc/init/nginx.conf':
    require => [
      File['/etc/nginx/conf.d/default.conf'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/init/nginx.conf',
    replace => 'no',
    mode    => '0644',
    owner   => root,
    group   => root,
  }

  exec { 'start nginx':
    require => [
      File['/etc/init/nginx.conf'],
    ],
    command => '/sbin/start nginx',
  }
}
