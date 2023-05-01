FROM arm64v8/alpine 
LABEL maintainer="Mr.Philipp <d3vilh@github.com>"
RUN apk add --no-cache unbound
RUN wget -S https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints
RUN unbound-anchor -4 -a /etc/unbound/root.key; exit 0

RUN touch /var/log/unbound.log
RUN chmod 775 /var/log/unbound.log; chown root:unbound /var/log/unbound.log
RUN chmod 775 /etc/unbound; chown root:unbound /etc/unbound

COPY ["/templates/unbound.conf", "/etc/unbound/"]

EXPOSE 53
EXPOSE 53/udp

ENTRYPOINT ["unbound", "-d"]