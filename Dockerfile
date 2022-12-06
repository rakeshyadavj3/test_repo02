#FROM nginx:latest
FROM ubuntu:20.04
#RUN watch date >> /var/log/date.log
WORKDIR /tmp
RUN apt-get -y update
RUN apt-get -y install git
RUN git clone https://github.com/rakeshyadavj3/cg.git
RUN cd /tmp/cg
