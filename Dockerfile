FROM debian:stretch-slim

RUN mkdir /data

ADD rdf.tgz /tmp
ADD gitty.tgz /tmp
COPY passwd /tmp

RUN mv /tmp/* /data &&  \
    chown -R root.root /data && \
    chmod -R 777 /data
