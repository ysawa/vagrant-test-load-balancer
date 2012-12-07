class dovecot {

  package { 'dovecot-core':
    require => [
      Exec['apt-get update after adding ppa'],
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
