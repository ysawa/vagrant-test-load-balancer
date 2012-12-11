class php5::install {

  $packages = [
    'php5-curl', 'php5-gd', 'php5-intl', 'php-pear', 'php5-imap', 'php5-mcrypt', 'php5-memcache', 'php5-recode', 'php5-snmp', 'php5-sqlite', 'php5-tidy', 'php5-xmlrpc', 'php5-xsl', 'php5-fpm', 'php5', 'php5-pspell',
  ]
  package { $packages:
    require => [
      # in order to install php5-fpm
      Class['ppa::repositories::nathan-renniewaldock-ppa'],
    ],
    ensure => installed,
  }

  service { 'php5-fpm':
    require => [
      Package['php5-fpm'],
    ],
    ensure => running,
  }
}
