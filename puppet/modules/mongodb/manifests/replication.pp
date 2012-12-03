class mongodb::replication {
  exec { "install replication":
    command => '/bin/echo "var config = {_id:\"set01\",members:[{_id:0, host:\"192.168.2.11:27017\"},{_id:1, host:\"192.168.2.12:27017\"},{_id:2, host:\"192.168.2.13:27017\"}]}; rs.initiate(config);" | /usr/bin/mongo',
    onlyif => '/bin/ls /usr/bin/mongod && /bin/ls /usr/bin/mongo', # TODO make condition more specifically
  }
}
