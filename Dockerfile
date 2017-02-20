FROM alpine:edge

LABEL description="Base image for alpine with s6 and no root process" \
      maintainer="Sven Fischer <sven@leiderfischer.de>"

ENV UID=991 GID=991

RUN echo "@community https://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && echo "@testing https://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk -U upgrade && apk add \
    s6 \
    su-exec \
 && rm -rf /var/cache/apk/* /tmp/* /root/.gnupg

COPY s6.d /etc/s6.d
COPY run.sh /run.sh

CMD ["/run.sh"]
