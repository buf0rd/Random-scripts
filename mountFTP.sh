#!/bin/bash

curlftpfs -o allow_other -o nonempty fayte:fayte@192.168.1.166/disk1/fayte/ /mnt/fayte/
curlftpfs -o allow_other -o nonempty public:public@192.168.1.166/disk1/public/ /var/www/html/filehost/
