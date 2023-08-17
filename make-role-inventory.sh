#!/bin/bash

path=/mnt/distr/ansible
cd $path
touch role-inventory && >role-inventory

echo '[all]' > role-inventory

echo "To break from input loop - print 0 / q instead of any IP or token fields"
i=0
while true
do
	echo "write IP: "
	read ip
	echo "write TOKEN: "
	read token

	if [[ $ip = "0" || $ip = "q" || $token = "0" || $token = "q" ]]; then
		break
	fi
	echo "$ip token=' $token '" >> role-inventory
	i=$((i+1))
done
echo "You are installing $i shops"


echo "[all:vars]" >> role-inventory

cat role-inventory


