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

  exec { 'use ppa:nginx/stable':
    require => [
      Package[$packages],
    ],
    command => '/usr/bin/add-apt-repository ppa:nginx/stable',
  }

  exec { 'use ppa:nathan-renniewaldock/ppa':
    require => [
      Package[$packages],
    ],
    command => '/usr/bin/add-apt-repository ppa:nathan-renniewaldock/ppa',
  }

  exec { 'apt-get update after adding ppa':
    require => [
      Exec['use ppa:nginx/stable'],
      Exec['use ppa:nathan-renniewaldock/ppa'],
    ],
    command => '/usr/bin/apt-get update',
  }
}
