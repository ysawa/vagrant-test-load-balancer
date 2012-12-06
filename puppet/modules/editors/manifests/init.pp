class editors {

  $editors = ['vim', 'emacs']
  package { $editors:
    ensure => "installed"
  }

  file { '/root/.vimrc':
    require => [
      Package['vim'],
    ],
    ensure  => 'file',
    source  => 'puppet:///modules/editors/vimrc',
    mode    => '0644',
    owner   => root,
    group   => root,
  }
}
