class ptetex3 {

  file { '/tmp/puppet_ptetex3_install.sh':
    require => [
      Package['build-essential'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/ptetex3/install.sh',
    mode    => '0700',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet_ptetex3_install.sh":
    require => [
      File['/tmp/puppet_ptetex3_install.sh'],
    ],
    cwd       => '/tmp/',
    timeout => 600,
    # unless => '/bin/ls /usr/local/ptetex3/libexec/check_dhcp',
  }
}
