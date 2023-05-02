FROM arm64v8/alpine
LABEL maintainer="Mr.Philipp <d3vilh@github.com>"
RUN apk add --no-cache unbound
#RUN wget -S https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints
RUN unbound-anchor -4 -a /etc/unbound/root.key; exit 0

RUN touch /var/log/unbound.log
RUN chmod 775 /var/log/unbound.log; chown root:unbound /var/log/unbound.log
RUN chmod 775 /etc/unbound; chown root:unbound /etc/unbound

# Uncomment to use embedded config. Better to use volume to pass the config file
# i.e: docker run  --interactive --tty --rm -p 5335:5335 -p 5335:5335/udp \
# -v /home/philipp/unbound-dns/etc-unbound/unbound.conf:/etc/unbound/unbound.conf \
# -v /home/philipp/unbound-dns/log-unbound/unbound.log:/var/log/unbound.log \
# -v /home/philipp/unbound-dns/etc-unbound/root.hints:/etc/unbound/root.hints \
# local/unbound:latest

#COPY ["/etc-unbound/unbound.conf", "/etc/unbound/"]

EXPOSE 5335
EXPOSE 5335/udp

ENTRYPOINT ["unbound", "-d"]