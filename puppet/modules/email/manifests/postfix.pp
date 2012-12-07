class email::postfix {

  package { 'postfix':
    require => [
      Exec['apt-get update after adding ppa'],
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
