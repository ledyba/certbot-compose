#! /bin/bash

echo [$(date)] Started.

CERTBOT="docker-compose run --service-ports --rm certbot certonly -vvv --agree-tos --email psi@7io.org --non-interactive --keep --standalone"

echo -n "hexe.net: "
RESULT="$(${CERTBOT} -d hexe.net -d ura.hexe.net -d sabbat.hexe.net 2>&1)"
if [ $? -eq 0 ]; then
  echo Success.
else
  echo Failure.
  echo "$RESULT"
fi

exit

echo -n "7io.org: "
RESULT="$(${CERTBOT} -d 7io.org -d app.7io.org -d arc.7io.org 2>&1)"
if [ $? -eq 0 ]; then
  echo Success.
else
  echo Failure.
  echo "$RESULT"
fi

echo -n "open-dokidokivisual.com: "
RESULT="$(${CERTBOT} -d open-dokidokivisual.com 2>&1)"
if [ $? -eq 0 ]; then
  echo Success.
else
  echo Failure.
  echo "$RESULT"
fi

echo -n "dokidokivisual.org: "
RESULT="$(${CERTBOT} -d dokidokivisual.org 2>&1)"
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

