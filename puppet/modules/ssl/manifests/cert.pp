define ssl::cert ($service = $title, $country = 'JP', $state = 'Tokyo') {

  # INFO_COUNTRY="Your Country Abbreviation"
  # INFO_STATE="Your State"
  # INFO_CITY="Your City"
  # INFO_ORGANIZATION="Your Company or Organization"
  # INFO_DEPARTMENT="Your Office or Department"

  package { 'install openssl for ssl::cert':
    require => [
    ],
    name   => 'openssl',
    ensure => installed,
  }

  file { '/tmp/puppet_ssl_cert.sh':
    require => [
      Package['install openssl for ssl::cert'],
    ],
    ensure  => file,
    content => template("ssl/cert.sh.erb"),
    mode    => 0700,
    owner   => root,
    group   => root,
  }

  exec { '/tmp/puppet_ssl_cert.sh':
    require => [
      File['/tmp/puppet_ssl_cert.sh'],
    ],
    cwd     => '/tmp/',
    unless  => "/bin/ls /etc/ssl/private/${service}.key",
  }

  exec { "move crt":
    require => [
      Exec['/tmp/puppet_ssl_cert.sh'],
    ],
    command => "/bin/mv /tmp/puppet-ssl-cert.crt /etc/ssl/certs/${service}.crt",
    onlyif => '/bin/ls /tmp/puppet-ssl-cert.crt',
    unless  => "/bin/ls /etc/ssl/certs/${service}.crt",
  }

  exec { "move csr":
    require => [
      Exec['/tmp/puppet_ssl_cert.sh'],
    ],
    command => "/bin/mv /tmp/puppet-ssl-cert.csr /etc/ssl/certs/${service}.csr",
    onlyif => '/bin/ls /tmp/puppet-ssl-cert.csr',
    unless  => "/bin/ls /etc/ssl/certs/${service}.csr",
  }

  exec { "move key":
    require => [
      Exec['/tmp/puppet_ssl_cert.sh'],
    ],
    command => "/bin/mv /tmp/puppet-ssl-cert.key /etc/ssl/private/${service}.key",
    onlyif => '/bin/ls /tmp/puppet-ssl-cert.key',
    unless  => "/bin/ls /etc/ssl/private/${service}.key",
  }
}
