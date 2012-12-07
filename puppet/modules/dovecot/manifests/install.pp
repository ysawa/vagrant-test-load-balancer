class dovecot::install {

  package { 'dovecot-core':
    require => [
      Class['ppa::repositories::nathan-renniewaldock-ppa'],
    ],
    ensure => installed,
  }

  service { 'dovecot':
    require => [
      Package['dovecot-core'],
    ],
    ensure => running,
  }
}
