class rvm {

  define user ($username = $title) {
    # curl -L https://get.rvm.io | bash -s stable --ruby
    # err: /Stage[main]//Node[app]/Rvm::User[app]/Exec[install rvm for app]/returns: change from notrun to 0 failed:   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
    #                                  Dload  Upload   Total   Spent    Left  Speed
    # 100   185  100   185    0     0    206      0 --:--:-- --:--:-- --:--:--   409
    # 100 10242  100 10242    0     0   5019      0  0:00:02  0:00:02 --:--:-- 26396
    # mkdir: cannot create directory `/root': Permission denied
    # sh: 1: source: not found
    exec { "install rvm for $username":
      require => [
        User[$username],
        Package['curl', 'bash', 'build-essential'],
      ],
      user => $username,
      command => "echo \"curl -L https://get.rvm.io | bash -s stable ; source /home/$username/.rvm/scripts/rvm\" | bash",
      path => [ "/bin/", "/usr/bin/", "/usr/local/bin/", "/home/$username/bin/" ],
      cwd => "/home/$username",
      timeout => 600,
      unless => "ls /home/$username/.rvm",
    }
  }
}
