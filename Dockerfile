# build and install ruby
FROM scratch as builder

ADD alpine-minirootfs-3.18.2-x86_64.tar.gz /
COPY ruby-2.7.8.tar.gz /tmp/ruby-2.7.8.tgz
COPY patches /tmp/patches
COPY install.sh /tmp/install.sh

RUN sh /tmp/install.sh

CMD ["sh"]

# reduce everything down to a single layer
FROM scratch
COPY --from=builder / /
CMD ["sh"]
