FROM wordpress:6.6.2-php8.3-apache AS build
RUN a2enmod headers
COPY ./security.conf /etc/apache2/conf-available/security.conf
COPY ./setup /tmp/setup

RUN apt-get update && apt-get install wget unzip && /tmp/setup

FROM wordpress:6.6.2-php8.3-apache AS final
COPY --from=build /etc/apache2/ /etc/apache2/
COPY --from=build /usr/src/wordpress/ /usr/src/wordpress/
COPY ./custom.ini /usr/local/etc/php/conf.d/
