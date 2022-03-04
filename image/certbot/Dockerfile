FROM python:3.9
USER root

ENV TZ JST-9

ADD "./src" "/src"

RUN pip install --upgrade pip && \
    pip install --upgrade setuptools &&\
    pip install /src/certbot/acme && \
    pip install /src/certbot/certbot && \
    pip install /src/certbot/certbot-dns-valuedomain

ENTRYPOINT [ "certbot" ]
