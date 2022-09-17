#!/bin/bash
grep "Invalid" /var/log/auth.log | sed -e 's/.*Invalid\(.*\)port.*/\1/' | tail -n 20 > /var/www/html/theworst.html
exit 0
