FROM mono:latest

RUN apt-get update \
    && apt-get -y install unzip 

