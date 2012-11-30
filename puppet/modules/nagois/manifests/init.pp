class nagois {

  user { 'nagois':
    ensure => present,
    managehome => false,
    shell => '/usr/sbin/nologin',
  }

  file { '/tmp/puppet_nagois_install.sh':
    require => [
      User['nagois'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/nagois/install.sh',
    mode    => '0700',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet_nagois_install.sh":
    require => [
      File['/tmp/puppet_nagois_install.sh'],
      Package['libgd2-xpm-dev'],
    ],
    cwd       => '/tmp/',
    # unless => '/bin/ls /usr/local/bin/nagois', # TODO make condition more specifically
  }
}
