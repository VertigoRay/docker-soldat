# SOLDAT SERVER DOCKER
# ---------------------------------------------
FROM debian:stable
MAINTAINER Hai Anh Hoang <hoanghaianh@gmail.com>

# update debian packages
RUN echo "update debian packages"
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y --force-yes install wget unzip

# install soldat server
RUN echo "install soldat server"
RUN mkdir soldat
RUN wget http://static.soldat.pl/downloads/soldatserver2.7.8_1.6.8.zip -P /soldat/
RUN cd soldat; unzip soldatserver2.7.8_1.6.8.zip 

# copy soldat config
RUN echo "copy configuration"
ADD ./config/  /soldat/

# post setup
RUN /bin/bash -c "source /soldat/setup.sh"

CMD /soldat/soldatserver 
