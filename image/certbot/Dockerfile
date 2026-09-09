FROM python:3.13
USER root

ENV TZ JST-9

# certbot-dns-valuedomain は zope.interface をトップレベルで import するが、
# 依存として宣言していないため明示的に入れる。
RUN pip install --upgrade pip setuptools && \
    pip install \
      certbot \
      certbot-dns-valuedomain \
      zope.interface

ENTRYPOINT [ "certbot" ]
