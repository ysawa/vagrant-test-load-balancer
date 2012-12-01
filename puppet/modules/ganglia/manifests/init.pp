class ganglia {

  $packages = ['ganglia-monitor', 'ganglia-webfrontend']
  package { $packages:
    require => [
      Package['fcgiwrap'],
      Service['fcgiwrap'],
    ],
    ensure => 'installed'
  }

  service { 'ganglia-monitor':
    require => [
      Package[$packages],
    ],
    ensure => 'running',
  }
}
