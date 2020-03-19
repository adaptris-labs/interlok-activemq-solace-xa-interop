FROM adaptris/interlok-base:latest-zulu-alpine

ADD lib /opt/interlok/lib
ADD webapps /opt/interlok/webapps
ADD config /opt/interlok/config

EXPOSE 8080 5555
