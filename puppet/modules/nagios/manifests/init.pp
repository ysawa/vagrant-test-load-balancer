class nagios {

  user { 'nagios':
    ensure => present,
    managehome => true,
  }

  file { '/tmp/puppet_nagios_install.sh':
    require => [
      User['nagios'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/nagios/install.sh',
    mode    => '0700',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet_nagios_install.sh":
    require => [
      File['/tmp/puppet_nagios_install.sh'],
      Package['libgd2-xpm-dev', 'build-essential', 'git-core', 'automake', 'autoconf'],
    ],
    cwd       => '/tmp/',
    unless => '/bin/ls /usr/local/nagios/bin/nagios', # TODO make condition more specifically
  }

  file { '/tmp/puppet_nagios_install_plugins.sh':
    require => [
      User['nagios'],
      Package['git-core', 'gettext'],
      Exec["/tmp/puppet_nagios_install.sh"],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/nagios/install_plugins.sh',
    mode    => '0700',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet_nagios_install_plugins.sh":
    require => [
      File['/tmp/puppet_nagios_install_plugins.sh'],
      Exec["/tmp/puppet_nagios_install.sh"],
    ],
    cwd       => '/tmp/',
    timeout => 600,
    onlyif => '/bin/ls /usr/local/nagios/bin/nagios', # TODO make condition more specifically
    unless => '/bin/ls /usr/local/nagios/libexec/check_dhcp', # TODO make condition more specifically
  }

  $nginx_directories = ['/var/log/nginx/nagios']
  file { $nginx_directories:
    require => [
      Package['nginx'],
      Exec["/tmp/puppet_nagios_install.sh"],
    ],
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'www-data',
    group   => 'www-data',
  }

  file { '/etc/nginx/conf.d/nagios.conf':
    require => [
      Package['nginx'],
      Exec["/tmp/puppet_nagios_install.sh"],
    ],
    ensure  => 'directory',
    replace => 'no',
    source  => 'puppet:///modules/nagios/nginx.conf',
    mode    => '0644',
    owner   => 'www-data',
    group   => 'www-data',
  }

  service { 'nagios':
    require => [
      Exec["/tmp/puppet_nagios_install.sh"],
      Exec["/tmp/puppet_nagios_install_plugins.sh"],
    ],
    ensure => 'running',
  }

  exec { 'reload nginx after installing nagios':
    require => [
      Service['nginx'],
      Service['nagios'],
    ],
    command => '/etc/init.d/nginx reload',
  }
}
