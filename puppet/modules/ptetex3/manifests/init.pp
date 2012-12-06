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

  file { '/tmp/puppet_ptetex3_my_option':
    require => [
      Package['build-essential'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/ptetex3/my_option',
    mode    => '0644',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet_ptetex3_install.sh":
    require => [
      File['/tmp/puppet_ptetex3_install.sh', '/tmp/puppet_ptetex3_my_option'],
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
