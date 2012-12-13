class essentials::install {

  $essentials = [
    'build-essential', 'automake', 'autoconf',
    'curl', 'bash',
    'gettext', 'gettext-base',
    'libxslt1.1', 'libxml2', 'libssl-dev', 'libffi-dev', 'libsqlite3-dev', 'libreadline6-dev', 'libgd2-xpm-dev',
    'git-core', 'subversion',
    'lv',
    'unzip', 'lha',
    'flex', 'bison',
  ]
  package { $essentials:
    require => [
      Exec['apt-get update'],
    ],
    ensure => installed,
  }
}
