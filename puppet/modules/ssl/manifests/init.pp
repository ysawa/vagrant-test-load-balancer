class ssl {

  $packages = ['openssl']
  package { $packages:
    ensure => "installed",
  }
}
