class postfix::install {

  package { 'postfix':
    require => [
      Class['ppa::repositories::nathan-renniewaldock-ppa'],
    ],
    ensure => installed,
  }

  service { 'postfix':
    require => [
      Package['postfix'],
    ],
    ensure => running,
  }
}
