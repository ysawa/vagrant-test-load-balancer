class email::postfix {

  package { 'postfix':
    ensure => 'installed',
  }
}
