FROM php:8.3-fpm

RUN apt update && apt install -y \
    nginx \ 
    zip

COPY ./Docker/default.conf /etc/nginx/conf.d

RUN pecl install xdebug \  
    && docker-php-ext-enable xdebug

COPY ./Docker/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY ./Docker/error_reporting.ini /usr/local/etc/php/conf.d/error_reporting.ini


WORKDIR /var/www/html

VOLUME /var/www/html
VOLUME /var/log/nginx

COPY --from=composer/composer:2-bin /composer /usr/bin/composer

EXPOSE 80 9000
COPY ./Docker/entrypoint.sh /etc/entrypoint.sh
ENTRYPOINT [ "/etc/entrypoint.sh" ]