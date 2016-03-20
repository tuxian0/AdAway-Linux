#!/bin/sh

srclst="hostssources.lst"
#touch "$srclst"

if [ -f hosts ] ; then
	cat hosts >> "$srclst"
fi

curl -L "http://adaway.org/hosts.txt" >> "$srclst"
curl -L "http://hosts-file.net/ad_servers.asp" >> "$srclst"
curl -L "http://winhelp2002.mvps.org/hosts.txt" >> "$srclst"
#For blocking youtube flash ads
echo "127.0.0.1       s.ytimg.com" >> "$srclst"

sudo cp "$srclst" /etc/hosts

. /etc/os-release

case $NAME in
	openSUSE)
		sudo systemctl restart network.service
		;;
	*)
		sudo /etc/init.d/networking restart
		;;
esac

echo "'hosts' file has been updated successfully..."
rm "$srclst"
