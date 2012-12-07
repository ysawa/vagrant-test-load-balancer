class ppa::repositories::nginx-stable {

  exec { 'use ppa:nginx/stable':
    require => [
      Class['ppa::install'],
    ],
    command => '/usr/bin/add-apt-repository ppa:nginx/stable',
  }

  exec { 'apt-get update after adding nginx/stable':
    require => [
      Exec['use ppa:nginx/stable'],
    ],
    command => '/usr/bin/apt-get update',
  }
}
