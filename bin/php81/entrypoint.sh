#!/bin/bash

# Start PHP-FPM in the background
php-fpm &

# Keep the container running
tail -f /dev/null
