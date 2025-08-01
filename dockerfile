FROM php:8.1-apache

# Instalar extensões do PHP necessárias para o Laravel
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-install zip pdo pdo_mysql

# Habilitar mod_rewrite do Apache
RUN a2enmod rewrite

# Configurar o diretório de trabalho
WORKDIR /var/www/html

# Copiar os arquivos do Laravel
COPY . /var/www/html

# Ajustar permissões
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage /var/www/html/bootstrap/cache

# Instalar o Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Expor a porta 80
EXPOSE 80

CMD ["apache2-foreground"]
