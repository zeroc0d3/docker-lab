FROM dockerlab/base-consul:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

RUN apk update \
    && apk add --update mariadb mariadb-common mariadb-client \
    && rm -rf /var/cache/apk/*

COPY rootfs/ /

ENTRYPOINT ["/init"]
CMD []

EXPOSE 3306
VOLUME ["/var/lib/mysql"]
