class emacs::install {

  $editors = ['emacs']
  package { $editors:
    ensure => installed,
  }
}
