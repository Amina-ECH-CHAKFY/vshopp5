# Use the official PHP image
FROM php:8.2-cli


# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libpq-dev

# Install PHP extensions
RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo pdo_pgsql


# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory
WORKDIR /app

# Copy the application files
COPY . .

# Install PHP dependencies
RUN composer install --optimize-autoloader --no-dev

# Optimize Laravel
RUN php artisan optimize

# Expose port 10000 (or the port your app uses)
EXPOSE 10000

# Start the application
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=10000"]





