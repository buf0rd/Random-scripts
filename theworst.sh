#!/bin/bash
cat /var/log/auth.log | grep Invalid | sed -e 's/.*Invalid\(.*\)port.*/\1/' | tail -n 20 > /var/www/html/theworst.html
exit 0
