#FROM nginx:latest
FROM alpine:3.14
RUN watch date >> /var/log/date.log
WORKDIR /tmp
RUN "git clone https://github.com/rakeshyadavj3/cg.git \
     && cd /tmp/cg"
