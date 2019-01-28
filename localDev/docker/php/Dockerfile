FROM php:7.2-apache

# Use default dev configuration
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Create moodle directories
RUN mkdir -m 0700 /moodledata
RUN chown www-data:www-data /moodledata
