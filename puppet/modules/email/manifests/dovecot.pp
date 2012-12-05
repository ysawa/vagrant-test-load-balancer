class email::dovecot {

  package { 'dovecot-core':
    ensure => 'installed',
  }
}
