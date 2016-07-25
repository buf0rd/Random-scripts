#!/bin/bash

rm /var/www/html/weather.html
weather="$(weather -f ZIPCODE)"
echo "$weather" > /var/www/html/weather.html

exit 0
