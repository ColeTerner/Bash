#!/bin/bash

echo "Write down full path to directory of .PFX cert(CISCO):"
read pfx_folder

echo "Write down .PFX FILENAME:"
read pfx_filename

echo "Write down NEW SHORT NAME of your .crt and .key FILES:"
read name

echo "1.Extracting  .CRT and .KEY file from .PFX-cert to $pfx_path"
openssl pkcs12 -in $pfx_folder -nokeys -out $name.crt
openssl pkcs12 -in $pfx_folder -nocerts -out $name.key

echo "2.SHOW .crt AND .key FILES in the NEW LOCATION:" 
cd $pfx_folder && ls -lah | grep "$name"

echo "3.COPY new files to /etc/ssl/private/ /etc/ssl/certs/ /usr/local/share/ca-certificates/:"

sudo cp $name.crt /etc/ssl/certs/
sudo cp $name.crt /usr/local/share/ca-certificates/
sudo cp $name.key /etc/ssl/private/
sudo chmod 777 $name.key
#sudo cp $name.key /usr/local/share/ca-certificates/

echo "NOW YOU CAN ADD NEW VPN_CONNECTION in Linux Gnome GUI , and select following files as CERT and PASSWORD:"
echo "CERT: /usr/local/share/ca-certificates/$name.crt"
echo "KEY: $pfx_folder/$name.key"
