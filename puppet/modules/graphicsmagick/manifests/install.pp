class graphicsmagick::install {

  package { ['imagemagick']:
    require => [
      Class['ppa::repositories::nathan-renniewaldock-ppa'],
    ],
    ensure => "installed"
  }

  file { '/tmp/puppet_graphicsmagick_install.sh':
    ensure  => file,
    source  => 'puppet:///modules/graphicsmagick/install.sh',
    mode    => 0777,
    owner   => root,
    group   => root,
  }

  exec { "/tmp/puppet_graphicsmagick_install.sh":
    require => [
      File['/tmp/puppet_graphicsmagick_install.sh'],
      Package['imagemagick'],
      Class['essentials'],
    ],
    cwd       => '/tmp/',
    unless => '/bin/ls /usr/local/bin/GraphicsMagick-config',
  }
}
