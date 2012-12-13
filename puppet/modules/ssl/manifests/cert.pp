define ssl::cert (
  $service = $title,
  $country = 'JP',
  $state = 'Tokyo',
  $city = 'Bunkyo-ku',
  $organization = 'Your Company or Organization',
  $department = 'Your Office or Department'
) {

  $script = "/tmp/puppet_ssl_cert_$service.sh"
  file { $script:
    require => [
      Package["openssl"],
    ],
    ensure  => file,
    content => template("ssl/cert.sh.erb"),
    mode    => 0700,
    owner   => root,
    group   => root,
  }

  exec { $script:
    require => [
      File[$script],
    ],
    cwd     => '/tmp/',
    unless  => "/bin/ls /etc/ssl/private/${service}.key",
  }

  exec { "move crt of $service":
    require => [
      Exec[$script],
    ],
    command => "/bin/mv /tmp/puppet-ssl-cert.crt /etc/ssl/certs/${service}.crt",
    onlyif => '/bin/ls /tmp/puppet-ssl-cert.crt',
    unless  => "/bin/ls /etc/ssl/certs/${service}.crt",
  }

  exec { "move csr of $service":
    require => [
      Exec[$script],
    ],
    command => "/bin/mv /tmp/puppet-ssl-cert.csr /etc/ssl/certs/${service}.csr",
    onlyif => '/bin/ls /tmp/puppet-ssl-cert.csr',
    unless  => "/bin/ls /etc/ssl/certs/${service}.csr",
  }

  exec { "move key of $service":
    require => [
      Exec[$script],
    ],
    command => "/bin/mv /tmp/puppet-ssl-cert.key /etc/ssl/private/${service}.key",
    onlyif => '/bin/ls /tmp/puppet-ssl-cert.key',
    unless  => "/bin/ls /etc/ssl/private/${service}.key",
  }
}
