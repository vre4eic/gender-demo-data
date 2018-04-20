FROM debian:stretch-slim

RUN mkdir /data

ADD rdf.tgz /data
ADD gitty.tgz /data
COPY passwd /data

# mv /tmp/* /data &&  \
RUN  chown -R root.root /data && \
     chmod -R 777 /data
