class ptetex3 {

  user { 'ptetex3':
    ensure => present,
    managehome => false,
  }

  file { '/tmp/puppet_ptetex3_install.sh':
    ensure  => file,
    source  => 'puppet:///modules/ptetex3/install.sh',
    mode    => 0700,
    owner   => root,
    group   => root,
  }

  file { '/tmp/puppet_ptetex3_my_option':
    require => [
      User['ptetex3'],
    ],
    ensure  => file,
    source  => 'puppet:///modules/ptetex3/my_option',
    mode    => 0644,
    owner   => ptetex3,
    group   => ptetex3,
  }

  exec { "/tmp/puppet_ptetex3_install.sh":
    require => [
      Package['build-essential', 'unzip'],
      File['/tmp/puppet_ptetex3_install.sh', '/tmp/puppet_ptetex3_my_option'],
      User['ptetex3'],
    ],
    cwd       => '/tmp/',
    timeout => 1200,
    # unless => '/bin/ls /usr/local/ptetex3/libexec/check_dhcp',
  }

#  exec { 'append bin into PATH':
#    command => 'cat "export PATH=/usr/local/teTeX/bin:$PATH" >> /etc/bashrc',
#    unless => '/bin/true',
#  }
}
