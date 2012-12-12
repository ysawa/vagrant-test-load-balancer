class logrotate::install {

  package { 'logrotate':
    ensure => installed
  }
}
