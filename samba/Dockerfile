FROM alpine:latest

RUN apk --update upgrade && apk add samba-server wget 

ADD configs/smb.conf /etc/samba/smb.conf

EXPOSE 137/udp 138/udp 139 445 

RUN mkdir -m 0777 -p /share; chown -R nobody:nobody /share

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
