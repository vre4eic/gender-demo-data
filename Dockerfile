FROM debian:stretch-slim

RUN mkdir /data

ADD rdf.tgz /tmp
ADD gitty.tgz /tmp
COPY passwd /tmp

RUN mv /tmp/toe /data/toe &&  \
    mv /tmp/data /data/data &&  \
    mv /tmp/passwd /data/passwd &&  \
    chown -R root.root /data && \
    chmod -R 777 /data/passwd && \
    chmod -R 777 /data/data
