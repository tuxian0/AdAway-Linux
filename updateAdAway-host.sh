#!/bin/bash

srclst="hostssources.lst"
touch "$srclst"

if [ -f hosts ] ; then
	cat hosts >> "$srclst"
fi
curl -L "http://adaway.org/hosts.txt" >> "$srclst"
curl -L "http://hosts-file.net/ad_servers.asp" >> "$srclst"
curl -L "http://winhelp2002.mvps.org/hosts.txt" >> "$srclst"
sudo cp "$srclst" /etc/hosts
osname=$(bash <(cat /etc/os-release; echo 'echo ${NAME/*, /}'))
case $osname in
	"openSUSE")
		sudo systemctl restart network.service
		;;
	*)
		sudo /etc/init.d/networking restart
		;;
esac
echo "'hosts' file has been updated successfully..."
rm "$srclst"