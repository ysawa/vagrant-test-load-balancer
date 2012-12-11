class ptetex3::install {

  user { 'ptetex3':
    ensure => present,
    managehome => false,
  }

  file { '/tmp/puppet_ptetex3_install.sh':
    require => [
      User['ptetex3'],
    ],
    ensure  => file,
    source  => 'puppet:///modules/ptetex3/install.sh',
    mode    => 0755,
    owner   => ptetex3,
    group   => ptetex3,
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

  # /usr/share/fonts/truetype/fonts-japanese-mincho.ttf

  # perl -p -i.bak -e 's/_IO_ssize_t getline (/_IO_ssize_t __getline (/' /usr/include/stdio.h
  # extern _IO_ssize_t getline (char **__restrict __lineptr,)
  # extern _IO_ssize_t __getline (char **__restrict __lineptr,)

  exec { "escape getline before compiling":
    path => ['/bin', '/usr/bin', '/usr/local/bin'],
    command => "perl -p -i.bak -e 's/_IO_ssize_t getline \\(/_IO_ssize_t __getline \\(/' /usr/include/stdio.h",
  }

  exec { "/tmp/puppet_ptetex3_install.sh":
    require => [
      Exec["escape getline before compiling"],
      Package['build-essential', 'unzip', 'flex', 'bison'],
      Class['fonts::install'],
      File['/tmp/puppet_ptetex3_install.sh', '/tmp/puppet_ptetex3_my_option'],
      User['ptetex3'],
    ],
    cwd     => '/tmp/',
    user    => ptetex3,
    timeout => 1500,
    unless => '/bin/ls /usr/local/teTeX/bin/platex',
  }

  exec { "make install":
    require => [
      Exec["/tmp/puppet_ptetex3_install.sh"],
    ],
    path => ['/bin', '/usr/bin', '/usr/local/bin'],
    cwd => '/tmp/ptetex3/ptetex3-20090504',
    command => "make install ; true",
    onlyif => 'ls /tmp/ptetex3/ptetex3-20090504',
    unless => 'ls /usr/local/teTeX/bin/platex',
  }

  exec { "unescape getline after compiling":
    require => [
      Exec["/tmp/puppet_ptetex3_install.sh"],
    ],
    path => ['/bin', '/usr/bin', '/usr/local/bin'],
    command => "mv /usr/include/stdio.h.bak /usr/include/stdio.h",
  }

#  exec { 'append bin into PATH':
#    command => 'cat "export PATH=/usr/local/teTeX/bin:$PATH" >> /etc/bashrc',
#    unless => '/bin/true',
#  }
}
