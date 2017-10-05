FROM dockerlab/base:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

ENV CONSULTEMPLATE_VERSION=0.19.3

RUN mkdir -p /var/lib/consul \
    && addgroup -S consul \
    && adduser -S -D -g "" -G consul -s /sbin/nologin -h /var/lib/consul consul \
    && chown -R consul:consul /var/lib/consul

RUN apk update \
    && apk add --update zip \
    && curl -sSL https://releases.hashicorp.com/consul-template/${CONSULTEMPLATE_VERSION}/consul-template_${CONSULTEMPLATE_VERSION}_linux_amd64.zip -o /tmp/consul-template.zip \
    && unzip /tmp/consul-template.zip -d /bin \
    && rm /tmp/consul-template.zip \
    && apk del zip \
    && rm -rf /var/cache/apk/*

COPY rootfs/ /

HEALTHCHECK CMD /etc/cont-consul/check || exit 1
