#! /bin/bash

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

ROOT_DIR="$(cd "$(readlink -f "$(dirname "$0")")" && pwd)"
cd "${ROOT_DIR}" || exit 1
set -e -u -o pipefail

echo [$(date)] Started.

function create() {
  echo "Crete a certificate with: " $(echo "$@" | sed -e "s/-d//g")
  docker-compose run \
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

sudo find data -type f -exec chmod 644 {} \;
sudo find data -type d -exec chmod 755 {} \;

