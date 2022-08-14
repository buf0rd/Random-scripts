#!/bin/bash

miniircd --port 33333 --motd /home/pi/miniircd/motd.txt  --password-file /home/pi/miniircd/password-file.txt --ssl-cert-file /home/pi/miniircd/cert.pem --ssl-key-file /home/pi/miniircd/key.pem
