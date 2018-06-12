#!/bin/sh

rtt=$(ping -c5 9.9.9.9 | grep rtt | cut -d"/" -f5)

rtt_rounded=$(printf '%.*f\n' 0 $rtt)

echo The average ping response to Quad9 is $rtt milliseconds

if [ "$rtt_rounded" -lt 50 ]; then

echo "Internet is up"

echo No action required.

#####LED 1 off

python <<END

import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(18,GPIO.OUT)

print "LED indictator is off"
GPIO.output(18,GPIO.LOW)

END


exit 0

else

echo "Internet is down"

#LED 1 on

python <<END

import RPi.GPIO as GPIO
import time


GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(18,GPIO.OUT)

print "LED indicator is on"
GPIO.output(18,GPIO.HIGH)

END

exit 0
fi

exit 0
