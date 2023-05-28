#!/bin/bash

# Start PHP-FPM in the background
php-fpm &

# Start Apache in the background
apache2-foreground
