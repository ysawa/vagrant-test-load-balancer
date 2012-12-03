class editors {

  $editors = ['vim', 'emacs']
  package { $editors:
    ensure => "installed"
  }
}
