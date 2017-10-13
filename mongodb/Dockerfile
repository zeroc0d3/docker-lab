FROM alpine:edge
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

ENV MONGODB_FILE=my-small \
    MONGODB_WORD=mongodb \
    MONGODB_MASK=172.30.0.% \
    MONGODB_BASE=mydb \
    MONGODB_NAME=docker \
    MONGODB_WORD=password \
    MONGODB_MASK=172.%.%.%

# ENV MONGODB_CONFIGSCRIPT=/root/run.sh 

RUN apk update \
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ mongodb \
    && rm -rf /var/cache/apk/* \
    && rm /usr/bin/mongoperf

COPY rootfs/ /

ENTRYPOINT [ "/root/run.sh" ]
CMD [ "mongod" ]

EXPOSE 27017
VOLUME ["/data/db"]