#!/bin/bash

##################################################
# Author : d0cs1s
##################################################
# Modification :
#----------------
# AUTHOR	DATE		COMMENT
# d0cs1s	05/07/22	Create script
###################################################

read -p "Saisir l'identifiant utilisateur souhaité : " user trash

menu()
{
	echo " GESTION DES UTILISATEURS : $user"
	echo "================================="
	echo "C - Créer le compte utilisateur"
	echo "M - Modifier le mot de passe de l'utlisateur"
	echo "S - Supprime le compte utilisateur"
	echo "V - Vérifie si le compte utilisateur existe"
	echo -e "U - Changer d'utilisateur\n"
	echo "Q - Quitter"
}

while true ; do
	menu
	read -p "Votre choix : " choice trash
	case $choice in
		C|c)
			echo "Créer le compte"
			useradd -m -s /bin/bash $user 2>/dev/null
			if [[ $? -eq 9 ]] ; then
				echo "le compte existe déjà"
			fi
			;;
		M|m)
			echo "Modifier le mot de passe"
			passwd $user
			;;
		S|s)
			echo "Supprime le compte utilisateur"
			userdel $user 2>/dev/null
			if [[ $? -eq 6 ]] ; then
				echo "le compte n'existe pas"
			else
				rm -rfd /home/$user 2>/dev/null
			fi
			;;
		V|v)
			grep ^$user: /etc/passwd 1>/dev/null
			if [[ $? -eq 0 ]] ; then
				echo "l'utilisateur existe"
			else
				echo "l'utilisateur n'existe pas"
			fi
			;;
		U|u)
			read -p "Changement : entrez le nouvel utilisateur : " user trash
			;;
		Q|q)
			echo "Fermeture du programme"
			exit 0
			;;
		*)
			echo "Vérifiez votre saisie"
			exit 1
			;;
	esac
	sleep 1s
	clear
done
