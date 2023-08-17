#!/bin/bash

path=/mnt/distr/ansible
cd $path
touch study-inventory && >study-inventory

#sshpass -p "fface-pwd1902" ssh fface@5.252.193.80 "bash license_list.sh" | awk -F ";" '{print $1,"\t",$2}'
#ntls_port_arr=$(sshpass -p "fface-pwd1902" ssh fface@5.252.193.80 "bash license_list.sh" | awk -F ";" '{print $2}')

#echo "Input NTLS:"
#read ntls

#count=0
#for item in ${ntls_port_arr[@]}
#do#
#	if [[ $ntls = 1 ]]; then
#		count=$((count+1))
#	fi
#done

#if [[ $count -ne 1 ]]; then
#	echo "Incorrect NTLS"
#	exit 1
#fi







echo '[all]' > study-inventory

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
	echo "$ip token=' $token '" >> study-inventory
	i=$((i+1))
done
echo "You are installing $i shops"

all_vars=("[all:vars]" "ansible_user=detect" "become-user=root" "ansible_password=detect-pwd" "ansible_become_pass=detect-pwd" "ansible_sudo_pass=detect-pwd" "license_ntls_server=face452k.bit-tech.co:3144" "ansible_python_interpreter=/usr/bin/python3" "timesrv=0.pool.ntp.org" "skip=1")

for string in ${all_vars[@]}
do
	echo $string >> study-inventory
done

cat study-inventory


