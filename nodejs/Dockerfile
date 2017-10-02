FROM dockerlab/base-consul:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ nodejs && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/init"]
CMD []
