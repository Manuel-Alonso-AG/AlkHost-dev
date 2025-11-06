FROM php:8.2-cli

RUN docker-php-ext-install pdo pdo_mysql mysqli

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php", "-S", "0.0.0.0:9000", "-t", "/var/www/html"]