class mongodb::replicaset {

  define initiate ($replicaset = $title, $host) {
    $script = "/tmp/puppet_mongodb_replacation_initiate_$replicaset.sh"
    file { $script:
      require => [
        Class['mongodb::install'],
      ],
      ensure => file,
      mode => 0755,
      owner => mongodb,
      group => mongodb,
      content => template("mongodb/replicaset/initiate.sh.erb"),
    }

    exec { $script:
      require => [
        Class['mongodb::install'],
      ],
      user => mongodb,
      onlyif => '/bin/ls /usr/bin/mongod && /bin/ls /usr/bin/mongo',
    }
  }
}
