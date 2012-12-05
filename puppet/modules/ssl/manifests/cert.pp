define ssl::cert ($service = $title) {

  package { 'install openssl':
    require => [
    ],
    name   => 'openssl',
    ensure => 'installed',
  }

  file { '/tmp/puppet_ssl_cert.sh':
    require => [
      Package['install openssl'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/ssl/cert.sh',
    mode    => '0700',
    owner   => root,
    group   => root,
  }

  exec { '/tmp/puppet_ssl_cert.sh':
    require => [
      File['/tmp/puppet_ssl_cert.sh'],
    ],
    cwd     => '/tmp/',
  }

  exec { "move crt":
    require => [
      Exec['/tmp/puppet_ssl_cert.sh'],
    ],
    command => "/bin/mv /tmp/puppet-ssl-cert.crt /etc/ssl/certs/${service}.crt",
    onlyif => '/bin/ls /tmp/puppet-ssl-cert.crt', # TODO make condition more specifically
    unless  => "/bin/ls /etc/ssl/certs/${service}.crt",
  }

  exec { "move csr":
    require => [
      Exec['/tmp/puppet_ssl_cert.sh'],
    ],
    command => "/bin/mv /tmp/puppet-ssl-cert.csr /etc/ssl/certs/${service}.csr",
    onlyif => '/bin/ls /tmp/puppet-ssl-cert.csr', # TODO make condition more specifically
    unless  => "/bin/ls /etc/ssl/certs/${service}.csr",
  }

  exec { "move key":
    require => [
      Exec['/tmp/puppet_ssl_cert.sh'],
    ],
    command => "/bin/mv /tmp/puppet-ssl-cert.key /etc/ssl/private/${service}.key",
    onlyif => '/bin/ls /tmp/puppet-ssl-cert.key', # TODO make condition more specifically
    unless  => "/bin/ls /etc/ssl/private/${service}.key",
  }
}
