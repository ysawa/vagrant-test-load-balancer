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

  $nginx_directories = ['/etc/nginx', '/etc/nginx/conf.d', '/var/run/nginx', '/var/log/nginx', '/var/tmp/nginx', '/var/lock/nginx']
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
    command => '/bin/chown -R nginx:nginx /etc/nginx/conf.d /var/run/nginx /var/log/nginx /var/lock/nginx /var/tmp/nginx; true',
  }

  file { '/etc/init.d/nginx':
    require => [
      Exec['chown nginx directories'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/nginx.sh',
    # replace => 'no',
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
    # replace => 'no',
    mode    => '0755',
    owner   => nginx,
    group   => nginx,
  }

  exec { 'sysv-rc-conf nginx on':
    require => [
      File['/etc/init.d/nginx', '/etc/nginx/nginx.conf'],
    ],
    command => '/usr/sbin/sysv-rc-conf nginx on',
  }
}
