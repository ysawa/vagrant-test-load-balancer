class hosts {

  host { 'web0':
    ip => '192.168.2.10'
  }

  host { 'app0':
    ip => '192.168.3.10'
  }

  host { 'app1':
    ip => '192.168.3.11'
  }

  host { 'app2':
    ip => '192.168.3.12'
  }
}
