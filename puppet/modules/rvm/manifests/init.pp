class rvm {

  define user ($username = $title) {
    # curl -L https://get.rvm.io | bash -s stable --ruby
    exec { "download rvm installer for $username":
      require => [
        User[$username],
        Package['curl'],
      ],
      user => $username,
      command => "curl -L https://get.rvm.io > rvm-install.sh ; chmod 755 rvm-install.sh",
      path => [ "/bin", "/usr/bin", "/usr/local/bin", "/home/$username/bin" ],
      cwd => "/home/$username",
      unless => "ls /home/$username/.rvm",
    }

    # exec { "/home/$username/rvm-install.sh":
    #   require => [
    #     User[$username],
    #     Exec["download rvm installer for $username"],
    #     Package['bash', 'build-essential'],
    #   ],
    #   user => $username,
    #   # command => "echo \"curl -L https://get.rvm.io | bash -s stable ; source /home/$username/.rvm/scripts/rvm\" | bash",
    #   # command => "curl -L https://get.rvm.io | bash -s stable",
    #   cwd => "/home/$username",
    #   timeout => 600,
    #   unless => "/bin/ls /home/$username/.rvm",
    # }
  }
}
