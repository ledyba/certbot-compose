#! /bin/bash

echo [$(date)] Started.

function create() {
  echo "Crete a certificate with: " $(echo "$@" | sed -e "s/-d//g")
  docker-compose run \
    --service-ports \
    --rm certbot \
      certonly \
        -vvv \
        --agree-tos \
        --email psi@7io.org \
        --non-interactive \
        --preferred-challenges dns-01 \
        --dns-valuedomain \
        --dns-valuedomain-propagation-seconds=90 \
        --dns-valuedomain-credentials=/etc/certbot/valuedomain.ini \
        --keep \
        "$@"
  if [ $? -eq 0 ]; then
    echo Success.
  else
    echo Failure.
    exit -1
  fi
}

create -d 'hexe.net' -d '*.hexe.net'
create -d '7io.org' -d '*.7io.org' -d '*.app.7io.org'
create -d 'ledyba.org' -d '*.ledyba.org'
create -d 'open-dokidokivisual.com' -d '*.open-dokidokivisual.com'
create -d 'dokidokivisual.org' -d '*.dokidokivisual.org'
create -d 'hexe.ink' -d '*.hexe.ink'

sudo find data -type f -exec chmod 644 {} \;
sudo find data -type d -exec chmod 755 {} \;
