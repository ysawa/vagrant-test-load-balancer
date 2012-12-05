class email::postfix {

  package { 'postfix':
    ensure => 'installed',
  }

  service { 'postfix':
    require => [
      Package['postfix'],
    ],
    ensure => 'running',
  }
}
