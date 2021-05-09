# https://pkgs.alpinelinux.org/packages?name=obfs4proxy&arch=x86_64
FROM alpine:latest

#ARG TOR_PACKAGE_VERSION=0.4.5.7-r0
#ARG OBFS4PROXY_PACKAGE_VERSION=0.0.11-r2
RUN apk update && apk add --no-cache tor=0.4.5.7-r0 -X http://dl-cdn.alpinelinux.org/alpine/edge/community

RUN apk add --no-cache obfs4proxy -X http://dl-cdn.alpinelinux.org/alpine/edge/testing

ENV OR_PORT=
ENV PT_PORT=
ENV CONTACT_INFO=
COPY torrc.template entrypoint.sh /
RUN chmod -c a+rX /torrc.template /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

USER tor
VOLUME /var/lib/tor
CMD ["tor", "-f", "/tmp/torrc"]
