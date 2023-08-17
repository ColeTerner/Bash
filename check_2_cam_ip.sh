#!/bin/bash

lip=`ip -br a show|grep UP|tail -n1|column -t| sed "s/  / /g"|cut -d " " -f3|sed "s%/.*%%"`;lip4=`echo $lip|cut -d "." -f4`;cam2=`echo "$lip4+2"|bc`;lip3=`echo $lip|cut -d "." -f1,2,3`;cam2ip=`echo "$lip3.$cam2"`;nc -z -w1 $cam2ip 80 &&echo ok||echo no
