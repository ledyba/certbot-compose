#! /bin/bash

echo [$(date)] Started.

LUNAR_ROOT="/opt/books/lunar"

echo -n "Renew: "
RESULT="$(docker-compose run --rm certbot renew -vvv 2>&1)"
if [ $? -eq 0 ]; then
  echo Success.
else
  echo Failure.
  echo "$RESULT"
fi

echo -n "Reloading nginx: "
RESULT="$(env --chdir="${LUNAR_ROOT}" docker-compose exec web /usr/sbin/nginx -s reload 2>&1)"
if [ $? -eq 0 ]; then
  echo Success.
else
  echo Failure.
  echo "$RESULT"
fi
