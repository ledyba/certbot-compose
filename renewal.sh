#! /bin/bash

echo [$(date)] Started.

PORTA_ROOT="/opt/books/porta"

echo -n "Renew: "
docker-compose run --rm certbot renew -vvv 2>&1

if [ $? -eq 0 ]; then
  echo Success.
else
  echo Failure.
  exit 255
fi

echo -n "Reloading nginx: "
env --chdir="${PORTA_ROOT}" docker-compose exec web /usr/sbin/nginx -s reload 2>&1
if [ $? -eq 0 ]; then
  echo Success.
else
  echo Failure.
  exit 255
fi
