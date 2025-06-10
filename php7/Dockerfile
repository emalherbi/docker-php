FROM php:7-apache

RUN apt-get update 

RUN apt-get install -y --no-install-recommends \
  unzip \
  unixodbc \
  unixodbc-dev \
  libpng-dev \
  libpq-dev \
  libzip4 \
  libzip-dev \
  && docker-php-ext-install zip \
  && docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
  && docker-php-ext-install pdo_odbc 

RUN docker-php-ext-install mysqli \
  && docker-php-ext-install pdo_mysql \
  && docker-php-ext-install gd \
  && rm -rf /var/lib/apt/lists/*

# RUN pecl install sqlsrv pdo_sqlsrv
# RUN echo "extension=sqlsrv.so" >> /usr/local/etc/php/php.ini
# RUN echo "extension=pdo_sqlsrv.so" >> /usr/local/etc/php/php.ini

RUN echo "date.timezone = America/Sao_Paulo" >> /usr/local/etc/php/php.ini
RUN echo "memory_limit = 2G" >> /usr/local/etc/php/php.ini
RUN echo "upload_max_filesize = 2G" >> /usr/local/etc/php/php.ini
RUN echo "post_max_size = 2G" >> /usr/local/etc/php/php.ini

RUN a2enmod rewrite

RUN rm -rf /var/lib/apt/lists/*

ADD 000-default.conf /etc/apache2/sites-available/

VOLUME ["/var/www/html"]

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
