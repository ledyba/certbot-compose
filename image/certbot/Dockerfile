FROM python:3.9
USER root

ENV TZ JST-9

RUN pip install --upgrade pip && \
    pip install --upgrade setuptools &&\
    pip install git+https://github.com/ledyba/lexicon.git@feature/valuedomain && \
    git clone -b feature/ValueDomain --single-branch https://github.com/ledyba/certbot.git /tmp/certbot && \
    pip install /tmp/certbot/certbot && \
    pip install /tmp/certbot/certbot-dns-valuedomain

ENTRYPOINT [ "certbot" ]
