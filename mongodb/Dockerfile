FROM alpine:edge
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

RUN apk update \
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ mongodb \
    && rm -rf /var/cache/apk/* \
    && rm /usr/bin/mongoperf

COPY rootfs/ /

ENTRYPOINT [ "/root/run.sh" ]
CMD [ "mongod" ]

EXPOSE 27017
VOLUME ["/data/db"]