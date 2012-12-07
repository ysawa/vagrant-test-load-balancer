class ppa::repositories::nathan-renniewaldock-ppa {

  exec { 'use ppa:nathan-renniewaldock/ppa':
    require => [
      Class['ppa::install'],
    ],
    command => '/usr/bin/add-apt-repository ppa:nathan-renniewaldock/ppa',
  }

  exec { 'apt-get update after adding nathan-renniewaldock/ppa':
    require => [
      Exec['use ppa:nathan-renniewaldock/ppa'],
    ],
    command => '/usr/bin/apt-get update',
  }
}
