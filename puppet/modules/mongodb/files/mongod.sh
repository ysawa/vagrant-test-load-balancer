#!/bin/bash

# mongod - Startup script for mongod

# chkconfig: 35 85 15
# description: Mongo is a scalable, document-oriented database.
# processname: mongod
# config: /etc/mongod.conf
# pidfile: /var/run/mongo/mongo.pid

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# things from mongod.conf get there by mongod reading it


# NOTE: if you change any OPTIONS here, you get what you pay for:
# this script assumes all options are in the config file.
CONFIGFILE="/etc/mongod.conf"
OPTIONS=" -f $CONFIGFILE"
SYSCONFIG="/etc/init.d/mongod"

# FIXME: 1.9.x has a --shutdown flag that parses the config file and
# shuts down the correct running pid, but that's unavailable in 1.8
# for now.  This can go away when this script stops supporting 1.8.
DBPATH=`awk -F= '/^dbpath=/{print $2}' "$CONFIGFILE"`
mongod=${MONGOD-/usr/local/bin/mongod}
LOCKFILE=/var/lock/mongo/mongod.lock

MONGO_USER=mongo
MONGO_GROUP=mongo

test -x $SYSCONFIG || exit 0

start()
{
  echo -n $"Starting mongod: "
  daemon --user "$MONGO_USER" $mongod $OPTIONS
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ] && touch $LOCKFILE
}

stop()
{
  echo -n $"Stopping mongod: "
  killproc -p $LOCKFILE -d 300 /usr/local/bin/mongod
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ] && touch $LOCKFILE
}

restart () {
        stop
        start
}

RETVAL=0

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart|reload|force-reload)
    restart
    ;;
  condrestart)
    [ -f $LOCKFILE ] && restart || :
    ;;
  status)
    status $mongod
    RETVAL=$?
    ;;
  *)
    echo "Usage: $0 {start|stop|status|restart|reload|force-reload|condrestart}"
    RETVAL=1
esac

# Starting mongod: /etc/init.d/mongod: line 37: daemon: command not found
