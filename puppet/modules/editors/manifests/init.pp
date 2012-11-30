class editors {

  $editors = ["vim"]
  package { $editors:
    ensure => "installed"
  }
}
