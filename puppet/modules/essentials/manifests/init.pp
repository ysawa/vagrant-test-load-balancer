class essentials {

  $essentials = ["build-essential", "libxslt1.1", "libxml2", "libssl-dev", "git-core", "libffi-dev", "libsqlite3-dev", "libreadline5-dev", "libgd2-xpm-dev"]
  package { $essentials:
    ensure => "installed"
  }
}
