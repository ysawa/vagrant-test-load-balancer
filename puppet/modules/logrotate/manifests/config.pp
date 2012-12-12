define logrotate::config ($service = $title, $template = 'logrotate.d/default.erb', $log) {

  $config = "/etc/logrotate.d/$service"
  file { $config:
    replace => no,
    content => template($template),
    mode => 0644,
    owner => root,
    group => root,
  }

  exec { "logrotate -f $config":
    require => [
      File[$config],
    ],
    path => ['/bin', '/usr/bin', '/usr/local/bin'],
    user => root,
  }
}
