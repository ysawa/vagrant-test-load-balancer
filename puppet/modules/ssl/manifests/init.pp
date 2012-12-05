class ssl {

  file { '/tmp/puppet_ssl_install.sh':
    ensure  => 'file',
    source  => 'puppet:///modules/ssl/install.sh',
    mode    => '0700',
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet_ssl_install.sh":
    require => [
      File["/tmp/puppet_ssl_install.sh"],
    ],
    cwd       => '/tmp/',
    # onlyif => '/bin/ls /usr/local/certs/bin/certs', # TODO make condition more specifically
    # unless => '/bin/ls /usr/local/certs/libexec/check_dhcp', # TODO make condition more specifically
  }
}
