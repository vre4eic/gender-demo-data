FROM debian:stretch-slim

RUN mkdir /data

ADD rdf.tgz /data
ADD gitty.tgz /data
COPY passwd /data

RUN useradd vre4eic_data
RUN chown -R vre4eic_data.vre4eic_data /data && \
    chmod -R 777 /data
