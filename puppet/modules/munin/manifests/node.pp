class munin::node {

  $packages = ['munin-node', 'munin-plugins-extra']
  package { $packages:
    require => [
      Package['munin'],
    ],
    ensure => 'installed'
  }

  service { 'munin-node':
    require => [
      Package[$packages],
    ],
    ensure => 'running',
  }
}
