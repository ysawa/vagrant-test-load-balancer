class email::dovecot {

  package { 'dovecot-core':
    ensure => 'installed',
  }

  service { 'dovecot':
    require => [
      Package['dovecot-core'],
    ],
    ensure => 'running',
  }
}
