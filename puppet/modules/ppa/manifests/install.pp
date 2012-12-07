class ppa::install {

  $packages = [
    'python-software-properties'
  ]
  package { $packages:
    require => [
      Exec['apt-get update'],
    ],
    ensure => installed,
  }
}
