#!/bin/bash

# Start PHP-FPM in the background
php-fpm &

# Start Apache in the foreground
exec apache2ctl -DFOREGROUND

