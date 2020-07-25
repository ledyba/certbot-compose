#! /bin/bash

echo [$(date)] Started.

CERTBOT="docker-compose run --service-ports --rm certbot certonly -vvv --agree-tos --email psi@7io.org --manual --keep --preferred-challenges dns-01"
LUNAR_ROOT=/opt/books/lunar
function create() {
  echo "Crete a certificate with: " $(echo "$@" | sed -e "s/-d//g")
  ${CERTBOT} "$@"
  if [ $? -eq 0 ]; then
    echo Success.
  else
    echo Failure.
    exit -1
  fi
}

create -d 'ledyba.org' -d '*.ledyba.org'
create -d '7io.org' -d '*.7io.org'
create -d 'hexe.net' -d '*.hexe.net'
create -d 'open-dokidokivisual.com' -d '*.open-dokidokivisual.com'
create -d 'dokidokivisual.org' -d '*.dokidokivisual.org'
create -d 'hexe.ink' -d '*.hexe.ink'

