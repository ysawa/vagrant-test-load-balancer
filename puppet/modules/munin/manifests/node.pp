class munin::node {

  $packages = ['munin-node', 'munin-plugins-extra']
  package { $packages:
    ensure => installed,
  }

  service { 'munin-node':
    require => [
      Package[$packages],
    ],
    ensure => running,
  }
}
