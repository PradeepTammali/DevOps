FROM alpine:3.8

MAINTAINER PradeepTammali

COPY vault /usr/local/bin/vault

EXPOSE 8888

ENTRYPOINT  ["vault", "server", "-dev", "-dev-listen-address=0.0.0.0:8888"]
