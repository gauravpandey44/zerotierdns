FROM alpine:latest

RUN apk --no-cache add dnsmasq \
    && apk  --no-cache add curl \
    && echo "conf-dir=/etc/dnsmasq.d" > /etc/dnsmasq.conf

# COPY .config /
COPY fetch-details.sh /
    
EXPOSE 53/tcp 53/udp

CMD ["/fetch-details.sh"]