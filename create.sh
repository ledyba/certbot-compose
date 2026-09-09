#! /bin/bash

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

ROOT_DIR="$(cd "$(readlink -f "$(dirname "$0")")" && pwd)"
cd "${ROOT_DIR}" || exit 1
set -e -u -o pipefail

echo [$(date)] Started.

# 第1引数はゾーン名。certbot-dns-valuedomain は認証情報ファイルに
# 対象ゾーンを書く必要があるため、ゾーンごとに ini を用意する。
function create() {
  local zone="$1"
  shift
  echo "Crete a certificate with: " $(echo "$@" | sed -e "s/-d//g")
  docker compose run \
    --rm certbot \
      certonly \
        -vvv \
        --agree-tos \
        --email psi@7io.org \
        --non-interactive \
        --preferred-challenges dns-01 \
        --authenticator dns-valuedomain \
        --dns-valuedomain-propagation-seconds=90 \
        --dns-valuedomain-credentials="/etc/certbot/valuedomain-${zone}.ini" \
        --keep \
        "$@"
  if [ $? -eq 0 ]; then
    echo Success.
  else
    echo Failure.
    exit -1
  fi
}

create 'hexe.net' -d 'hexe.net' -d '*.hexe.net'
create '7io.org' -d '7io.org' -d '*.7io.org'
create 'ledyba.org' -d 'ledyba.org' -d '*.ledyba.org'
create 'outsider-science-lab.com' -d 'outsider-science-lab.com' -d '*.outsider-science-lab.com'

sudo find data -type f -exec chmod 644 {} \;
sudo find data -type d -exec chmod 755 {} \;
