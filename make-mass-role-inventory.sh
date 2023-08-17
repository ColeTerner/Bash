#!/bin/bash

cd /mnt/distr/ansible
>role-inventory

#input data
echo "[all]" >> role-inventory

#fill the arrays of IPs and TOKENs

#ip_list
touch ip_list && >ip_list
nano ip_list
#ip_arr=$(cat ip_list)
readarray ip_arr < ip_list


#token_list
touch token_list && >token_list
nano token_list
#token_arr=$(cat token_list)
readarray token_arr < token_list

if [[ ${#ip_arr[@]} != ${#token_arr[@]} ]]; then
	echo "IPs and TOKENs numbers ARE NOT EQUAL!"
	exit 1
fi 

number=$((${#ip_arr[@]}-1))
echo $number
records=()


for ((i=0;i<$number;i++))
do
	ip=$(echo ${ip_arr[i]} | tr -d '\r\n ')
	token=$(echo ${token_arr[i]} | tr -d '\r\n ')
	echo "$ip token=' $token '" >> role-inventory
done

echo ${records[@]}



echo "[all:vars]" >> role-inventory

cat role-inventory
