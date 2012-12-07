class essentials {

  $essentials = [
    'build-essential', 'automake', 'autoconf',
    'gettext', 'gettext-base',
    'libxslt1.1', 'libxml2', 'libssl-dev', 'git-core', 'libffi-dev', 'libsqlite3-dev', 'libreadline6-dev', 'libgd2-xpm-dev',
    'lv',
    'unzip', 'lha',
  ]
  package { $essentials:
    require => [
      Exec['apt-get update'],
    ],
    ensure => installed,
  }
}
