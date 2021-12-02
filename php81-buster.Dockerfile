FROM php:8.1-fpm-buster

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    wget \
    curl \
    libonig-dev \
    libmcrypt-dev \
    libxml2 \
    libxml2-dev \
    zlib1g-dev \
    autoconf \
    openssl \
    libssl-dev \
    libpng-dev \
    libpq-dev \
    libpng-dev \
    imagemagick \
    libzip-dev \
    libxslt-dev \
    libgcrypt-dev \
    libonig-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev

RUN pecl channel-update pecl.php.net && \
    pecl install mcrypt redis-5.3.4 && \
    rm -rf /tmp/pear

RUN docker-php-ext-install \
    mysqli \
    mbstring \
    pdo \
    pdo_mysql \
    xml \
    pcntl \
    bcmath \
    pdo_pgsql \
    zip \
    intl \
    gettext \
    soap \
    sockets \
    xsl

RUN docker-php-ext-configure gd --with-freetype=/usr/lib/ --with-jpeg=/usr/lib/ && \
    docker-php-ext-install gd

RUN docker-php-ext-enable redis

RUN cp /etc/ssl/certs/ca-certificates.crt /opt/cert.pem

COPY runtime/bootstrap /opt/bootstrap
COPY runtime/bootstrap.php /opt/bootstrap.php
COPY runtime/php.ini /usr/local/etc/php/php.ini

RUN chmod 755 /opt/bootstrap
RUN chmod 755 /opt/bootstrap.php

ENTRYPOINT []

CMD /opt/bootstrap