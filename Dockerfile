FROM php:7.4.28-apache
COPY src/ /var/www/html/
EXPOSE 80