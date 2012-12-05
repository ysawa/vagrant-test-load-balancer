class certs {

  file { '/tmp/puppet_certs_install.sh':
    ensure  => 'file',
    source  => 'puppet:///modules/certs/install.sh',
    mode    => '0700',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet_certs_install.sh":
    require => [
      File["/tmp/puppet_certs_install.sh"],
    ],
    cwd       => '/tmp/',
    # onlyif => '/bin/ls /usr/local/certs/bin/certs', # TODO make condition more specifically
    # unless => '/bin/ls /usr/local/certs/libexec/check_dhcp', # TODO make condition more specifically
  }
}
