#!/bin/bash

read -p "Saisir l'identifiant utilisateur souhaité : " user trash

menu()
{
	echo " GESTION DES UTILISATEURS : $user"
	echo "================================="
	echo "C - Créer le compte utilisateur"
	echo "M - Modifier le mot de passe de l'utlisateur"
	echo "S - Supprime le compte utilisateur"
	echo -e "V - Vérifie si le compte utilisateur existe\n"
	echo "Q - Quitter"
}

while true ; do
	menu
	read -p "Votre choix : " choice trash
	case $choice in
		C|c)
			echo "Créer le compte"
			useradd -m -s /bin/bash $user
			;;
		M|m)
			echo "Modifier le mot de passe"
			passwd $user
			;;
		S|s)
			echo "Supprime le compte utilisateur"
			userdel $user
			rm -rfd /home/$user
			;;
		V|v)
			grep $user /etc/passwd 1>/dev/null
			code=$?
			if [[ $code -eq 0 ]] ; then
				echo "l'utilisateur existe"
			else
				echo "l'utilisateur n'existe pas"
			fi
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
