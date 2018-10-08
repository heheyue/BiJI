#!/bin/bash
filename=`ls -t /home/seim/clint_apk/| awk -F'.apk' '{print $1}' | grep 'hongsongOA' | sed -n '1p'`
chmod -R 777 /home/seim/clint_apk/*
echo "$filename"
sed -i "s@\"http://hsh5.syberos.com.*\"@\"http://hsh5.syberos.com/apk_download/$filename.apk\"@g" /home/seim/clint_apk/index.html
