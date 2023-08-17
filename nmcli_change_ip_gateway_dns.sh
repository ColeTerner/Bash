#!/bin/bash

sleep 12
nmcli con

nmcli con mod 'Проводное соединение 1' ipv4.addresses "10.19.58.145/27"
nmcli con mod 'Проводное соединение 1' ipv4.gateway "10.19.58.158"
nmcli con mod 'Проводное соединение 1' ipv4.dns "9.6.24.95 9.6.24.96"

