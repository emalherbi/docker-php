FROM php:7.4-apache

# Install system dependencies and core PHP extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    unzip \
    unixodbc \
    unixodbc-dev \
    libpng-dev \
    libpq-dev \
    libzip-dev \
  && docker-php-ext-install zip mysqli pdo_mysql gd \
  && docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
  && docker-php-ext-install pdo_odbc \
  && rm -rf /var/lib/apt/lists/*

# Install Microsoft ODBC Driver 17 (Debian Bullseye / PHP 7.4)
# Use trusted.gpg.d/ because Debian 11 prod.list has no signed-by clause
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg \
  && curl -fsSL https://packages.microsoft.com/config/debian/11/prod.list \
    -o /etc/apt/sources.list.d/mssql-release.list \
  && apt-get update \
  && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
  && rm -rf /var/lib/apt/lists/*

# Install sqlsrv 5.10.1 — last release with PHP 7.4 support
RUN pecl install sqlsrv-5.10.1 pdo_sqlsrv-5.10.1 \
  && docker-php-ext-enable sqlsrv pdo_sqlsrv

# Install Composer
RUN curl -fsSL https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer

# PHP configuration
RUN echo "date.timezone = America/Sao_Paulo" >> /usr/local/etc/php/php.ini \
  && echo "memory_limit = 2G" >> /usr/local/etc/php/php.ini \
  && echo "upload_max_filesize = 2G" >> /usr/local/etc/php/php.ini \
  && echo "post_max_size = 2G" >> /usr/local/etc/php/php.ini \
  && echo "max_execution_time = 300" >> /usr/local/etc/php/php.ini

RUN a2enmod rewrite

ADD 000-default.conf /etc/apache2/sites-available/

EXPOSE 80 443
