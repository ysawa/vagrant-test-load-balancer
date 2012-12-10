class rvm {

  define user ($username = $title) {

    file { "/home/$username/rvm-install.sh":
      require => [
        User[$username],
      ],
      ensure  => file,
      mode    => 0755,
      replace => no,
      group => $username,
      owner => $username,
      source  => 'puppet:///modules/rvm/install.sh',
    }
  }
}
