#! /bin/bash

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

ROOT_DIR="$(cd "$(readlink -f "$(dirname "$0")")" && pwd)"
cd "${ROOT_DIR}" || exit 1
set -e -u -o pipefail


# https://github.com/docker/compose/issues/5696
export COMPOSE_INTERACTIVE_NO_CLI=1

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

