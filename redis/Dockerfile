FROM bhuisgen/alpine-base-consul:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

RUN apk add --update redis && \
    rm -rf /var/cache/apk/*

COPY rootfs/ /

ENTRYPOINT ["/init"]
CMD []

EXPOSE 6379
VOLUME ["/var/lib/redis"]
