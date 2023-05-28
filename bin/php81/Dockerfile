FROM php:8.1-fpm-buster

# Surpresses debconf complaints of trying to install apt packages interactively
ARG DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    nano wget apache2 dialog libsqlite3-dev libsqlite3-0 default-mysql-client \
    zlib1g-dev libzip-dev libicu-dev apt-utils build-essential git curl \
    libonig-dev iputils-ping libcurl4 libcurl4-openssl-dev zip openssl \
    libmagickwand-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# Install xdebug
RUN pecl install xdebug-3.1.4 && docker-php-ext-enable xdebug && mkdir /var/log/xdebug

# Install redis
RUN pecl install redis-5.3.3 && docker-php-ext-enable redis

# Install imagick
RUN git clone https://github.com/Imagick/imagick /usr/local/src/imagick \
    && cd /usr/local/src/imagick \
    && git checkout 661405abe21d12003207bc8eb0963fafc2c02ee4 \
    && phpize && ./configure && make && make install \
    && rm -rf /usr/local/src/imagick \
    && docker-php-ext-enable imagick

# Install other PHP8 extensions
RUN docker-php-ext-install pdo_mysql pdo_sqlite bcmath mysqli curl zip intl \
    mbstring gettext calendar exif

# Configure and enable GD extension
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Enable Apache modules and HTTP/2
RUN a2enmod ssl rewrite headers http2 \
    && echo "Protocols h2 http/1.1" >> /etc/apache2/conf-available/http2.conf \
    && a2enconf http2

# Set document root
WORKDIR /var/www/html

# Cleanup
RUN rm -rf /var/www/html/* /usr/src/*

# Set user/group ID for www-data
RUN usermod -u 1001 www-data

