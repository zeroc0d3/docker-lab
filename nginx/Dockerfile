FROM dockerlab/base-consul:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

RUN mkdir -p /var/www \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -S -D -g "" -G www-data www-data

RUN apk update \
    && apk add --update nginx \
    && rm -rf /var/cache/apk/* \

COPY rootfs/ /

ENTRYPOINT ["/init"]
CMD []

EXPOSE 80 443
VOLUME ["/var/cache/nginx", "/var/www"]
