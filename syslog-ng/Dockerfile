FROM alpine:latest

RUN apk --update upgrade && apk add syslog-ng

ADD configs/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf

EXPOSE 514/udp

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
