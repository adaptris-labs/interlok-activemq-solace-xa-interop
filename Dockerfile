FROM adaptris/interlok-base:latest-zulu-alpine

COPY lib /opt/interlok/lib
COPY webapps /opt/interlok/webapps
COPY config /opt/interlok/config

EXPOSE 8080 5555
