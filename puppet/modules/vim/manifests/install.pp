class vim::install {

  $editors = ['vim']
  package { $editors:
    ensure => installed,
  }

  file { '/root/.vimrc':
    require => [
      Package['vim'],
    ],
    ensure  => file,
    source  => 'puppet:///modules/vim/vimrc',
    replace => no,
    mode    => 0644,
    owner   => root,
    group   => root,
  }
}
