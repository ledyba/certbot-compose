#! /bin/bash

echo [$(date)] Started.

WEBROOT="/opt/books/lunar/www/_http"
LUNAR_ROOT="/opt/books/lunar"
CERTBOT="docker-compose run --rm certbot"

echo -n "renew"
RESULT="$(${CERTBOT} renew --email psi@7io.org -nvvv --keep --webroot -w ${WEBROOT} -d hexe.net -d ura.hexe.net -d sabbat.hexe.net 2>&1)"
if [ $? -eq 0 ]; then
  echo Success.
else
  echo Failure.
  echo "$RESULT"
fi

echo -n "Reloading nginx: "
RESULT="$(cd ${LUNAR_ROOT} && docker-compose exec web /usr/sbin/nginx -s reload 2>&1)"
if [ $? -eq 0 ]; then
  echo Success.
else
  echo Failure.
  echo "$RESULT"
fi

