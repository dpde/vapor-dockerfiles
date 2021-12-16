FROM denizp/vapor:php81-buster

RUN apt-get update -y
RUN apt-get -y install libreoffice

COPY . /var/task
