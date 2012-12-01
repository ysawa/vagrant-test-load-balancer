class php5 {

  $packages = [
    'php5-curl', 'php5-gd', 'php5-intl', 'php-pear', 'php5-imap', 'php5-mcrypt', 'php5-memcache', 'php5-recode', 'php5-snmp', 'php5-sqlite', 'php5-tidy', 'php5-xmlrpc', 'php5-xsl', 'php5-fpm', 'php5', 'php5-pspell',
    # 'php5-ming', 'php5-ps', 'php5-mysql', 'php5-xcache', 'php5-imagick',
  ]
  package { $packages:
    require => [
      Exec['use ppa:nathan-renniewaldock/ppa'],
      # Exec["/tmp/puppet_php5_ppa.sh"],
      Exec['apt-get update after adding ppa'],
    ],
    ensure => "installed"
  }

  service { 'php5-fpm':
    require => [
      Package['php5-fpm'],
    ],
    ensure => 'running',
  }
}
