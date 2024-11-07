#!/bin/sh

if [ "$DATABASE" = "mysql" ]
then
  echo "Waiting for MySQL..."

  while ! nc -z $MYSQL_HOSTNAME $MYSQL_PORT; do
    sleep 0.1
  done

  echo "MySQL started"
fi

exec "$@"