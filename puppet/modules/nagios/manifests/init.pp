class nagios {

  user { 'nagios':
    ensure => present,
    managehome => true,
  }

  file { '/tmp/puppet_nagios_install.sh':
    require => [
      User['nagios'],
      Package['build-essential', 'git-core'],
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
      Package['libgd2-xpm-dev'],
    ],
    cwd       => '/tmp/',
    unless => '/bin/ls /usr/local/nagios/bin/nagios', # TODO make condition more specifically
  }

  file { '/tmp/puppet_nagios_install_plugins.sh':
    require => [
      User['nagios'],
      Package['git-core'],
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
    onlyif => '/bin/ls /usr/local/nagios/bin/nagios', # TODO make condition more specifically
    # unless => '/bin/ls /usr/local/nagios/bin/nagios', # TODO make condition more specifically
  }

  $nginx_directories = ['/var/log/nginx/nagios']
  file { $nginx_directories:
    require => [
      Package['nginx'],
      Exec["/tmp/puppet_nagios_install.sh"],
    ],
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'nginx',
    group   => 'nginx',
  }

  file { '/etc/nginx/conf.d/nagois.conf':
    require => [
      Package['nginx'],
      Exec["/tmp/puppet_nagios_install.sh"],
    ],
    ensure  => 'directory',
    # replace => 'no',
    source  => 'puppet:///modules/nagios/nginx.conf',
    mode    => '0644',
    owner   => 'nginx',
    group   => 'nginx',
  }

  service { 'nagois':
    require => [
      Exec["/tmp/puppet_nagios_install.sh"],
      Exec["/tmp/puppet_nagios_install_plugins.sh"],
    ],
    ensure => 'running',
  }
}
