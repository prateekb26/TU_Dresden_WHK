FROM ubuntu:16.04


RUN apt-get update
RUN apt-get -y install docker
COPY script.sh /

CMD ["bash", "/script.sh"]
