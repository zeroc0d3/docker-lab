FROM dockerlab/base-consul:latest
MAINTAINER ZeroC0D3 Team <zeroc0d3.team@gmail.com>

RUN apk add --update ruby ruby-irb ruby-rdoc && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/init"]
CMD []
