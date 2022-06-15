#!/bin/bash

if [ $# = 0 ];
then
	echo "Usage: ./save-net-conf.sh <compte> <ip> Il faut avoir créer des clés pour ssh au préalable"
else
	echo "Connexion à $2 avec le compte $1"
	mkdir backup-net-$2
	scp $1@$2:/etc/network/interfaces ./backup-net-$2/interfaces
	scp $1@$2:/etc/resolv.conf ./backup-net-$2/resolv.conf
	scp $1@$2:/etc/apt/sources.list ./backup-net-$2/sources.list
	echo "Sauvegarde de la configuration de $2"
fi
