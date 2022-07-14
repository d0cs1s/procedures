#!/bin/bash

#       Backup of Raspberry Pi
#--------------------------------------
#
# Author	: d0cs1s
# Creation	: 2022-07-07
# Modification	: -

date=$(date +%Y-%m-%d)

func_print_help() {
	echo "Syntax : ./backup_raspberry.sh <option>"
	echo "Option : 	-c | --crontab		Silent script to use in crontab"
	echo "		-v | --verbose		Verbose mode. Give some statistics"
}

func_check_args() {
	case $1 in
		-c|--crontab)
			# Silent mode
			echo "$date - starting backup" >> /var/log/backup_pi.log
			dd bs=4M if=/dev/mmcblk0 of=/media/partage/backup_img_pi/backup_pi-$date.img &>>/var/log/backup_pi.log
			sleep 5
			pigz /media/partage/backup_img_pi/backup_pi-$date.img &>>/var/log/backup_pi.log
			sleep 1
			echo "backup - finished" >> /var/log/backup_pi.log
			;;
		-v|--verbose)
			func_verbose_mode
			;;
		*)
			echo "Wrong option"
			func_print_help
			;;
	esac
}

func_verbose_mode() {
	read -p "Backup's name ? (without .img) : " name trash
	echo "Your backup will be located in /media/partage/backup_imp_pi/$name.img"
	time=$(date +%H:%M\'%S)
	echo "Job started at $time" | tee /var/log/backup_pi.log
	SECONDS=0
	dd bs=4M if=/dev/mmcblk0 of=/media/partage/backup_img_pi/$name.img status=progress
	echo "Transfert complete. Start compression ..." | tee /var/log/backup_pi.log
	sleep 2 
	pigz -v /media/partage/backup_img_pi/$name.img
	time=$(date +%H:%M\'%S)
	echo "Compression complete ! Job finished at $time" | tee /var/log/backup_pi.log
	duration=$SECONDS
	echo "Time elapsed :$(( $duration / 60 )) minutes and $(( $duration % 60 )) seconds elapsed." |tee /var/log/backup_pi.log
}


if [[ -z $1 ]] ; then
	func_print_help
else
	arg=$1
	func_check_args "$arg"
fi
