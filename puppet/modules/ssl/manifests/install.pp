class ssl::install {

  package { 'openssl':
    ensure => installed
  }
}
