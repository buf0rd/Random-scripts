#!/bin/bash
ipmitool -I lanplus -H 192.168.1.209 -U root -P calvin raw 0x30 0x30  0x01 0x00
ipmitool -I lanplus -H 192.168.1.209 -U root -P calvin raw 0x30 0x30 0x02 0xFF 0xB
echo Server quiet done!
