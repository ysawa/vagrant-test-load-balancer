class munin::node {

  $packages = ['munin-node', 'munin-plugins-extra']
  package { $packages:
    ensure => installed,
  }

  file { '/etc/munin/munin-node.conf.puppet':
    require => [
      Package[$packages],
    ],
    ensure  => file,
    content => template("munin/munin-node.conf.erb"),
    mode    => 0644,
    owner   => root,
    group   => root,
  }

  exec { 'replace /etc/munin/munin-node.conf':
    require => [
      File['/etc/munin/munin-node.conf.puppet'],
      Package[$packages],
    ],
    command => '/bin/mv /etc/munin/munin-node.conf.puppet /etc/munin/munin-node.conf',
    unless => '/usr/bin/test `/bin/cat /etc/munin/munin-node.conf | /bin/grep -c "USED BY PUPPET$"` -ne 0',
  }

  file { '/etc/munin/plugin-conf.d/munin-node.puppet':
    require => [
      Package[$packages],
    ],
    ensure  => file,
    content => template("munin/plugin-conf.d/munin-node.erb"),
    mode    => 0644,
    owner   => root,
    group   => root,
  }

  exec { 'replace /etc/munin/plugin-conf.d/munin-node':
    require => [
      File['/etc/munin/plugin-conf.d/munin-node.puppet'],
      Package[$packages],
    ],
    command => '/bin/mv /etc/munin/plugin-conf.d/munin-node.puppet /etc/munin/plugin-conf.d/munin-node',
    unless => '/usr/bin/test `/bin/cat /etc/munin/plugin-conf.d/munin-node | /bin/grep -c "USED BY PUPPET$"` -ne 0',
  }

  exec { 'restart munin-node after installing munin-node':
    require => [
      Package[$packages],
      Exec['replace /etc/munin/munin-node.conf'],
      Exec['replace /etc/munin/plugin-conf.d/munin-node'],
    ],
    command => '/usr/sbin/service munin-node reload ; /bin/true',
  }

  service { 'munin-node':
    require => [
      Exec['restart munin-node after installing munin-node'],
    ],
    ensure => running,
  }
}
