# SOLDAT SERVER DOCKER
# ---------------------------------------------
FROM debian:stable
MAINTAINER Hai Anh Hoang <hoanghaianh@gmail.com>

# update debian packages
RUN echo "update debian packages"
RUN apt-get update
RUN apt-get upgrade -y

# install soldat server
RUN echo "installing soldat server"
