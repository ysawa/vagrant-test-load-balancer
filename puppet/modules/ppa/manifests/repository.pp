define ppa::repository ($repository = $title) {

  exec { "use ppa:$repository":
    require => [
      Class["ppa::install"],
    ],
    command => "/usr/bin/add-apt-repository ppa:$repository",
  }

  exec { "apt-get update after adding $repository":
    require => [
      Exec["use ppa:$repository"],
    ],
    command => "/usr/bin/apt-get update",
  }
}
