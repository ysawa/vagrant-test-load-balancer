class nagios {

  user { 'nagios':
    ensure => present,
    managehome => true,
  }

  file { '/tmp/puppet_nagios_install.sh':
    require => [
      User['nagios'],
      Package['git-core'],
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
}
