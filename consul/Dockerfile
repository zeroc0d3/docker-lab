FROM dockerlab/base:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

ENV CONSUL_VERSION=0.9.3 \
    CONSULTEMPLATE_VERSION=0.19.3

RUN mkdir -p /var/lib/consul \
    && addgroup -S consul \
    && adduser -S -D -g "" -G consul -s /sbin/nologin -h /var/lib/consul consul \
    && chown -R consul:consul /var/lib/consul

RUN apk update \
    && apk upgrade \
    && apk add --update zip \
    && curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o /tmp/consul.zip \
    && unzip /tmp/consul.zip -d /bin \
    && rm /tmp/consul.zip \
    && curl -sSL https://releases.hashicorp.com/consul-template/${CONSULTEMPLATE_VERSION}/consul-template_${CONSULTEMPLATE_VERSION}_linux_amd64.zip -o /tmp/consul-template.zip \
    && unzip /tmp/consul-template.zip -d /bin \
    && rm /tmp/consul-template.zip \
    && apk del zip \
    && rm -rf /var/cache/apk/*

COPY rootfs/ /

ENTRYPOINT ["/init"]
CMD []

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8500 8501 8600 8600/udp
VOLUME ["/var/lib/consul"]

HEALTHCHECK CMD /etc/consul.d/check || exit 1
