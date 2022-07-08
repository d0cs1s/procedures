#!/bin/bash

#       Backup of Raspberry Pi
#--------------------------------------
#
# Author	: d0cs1s
# Creation	: 2022-07-07
# Modification	: -

source ~/scripts/library/time.func

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
			dd bs=4M if=/dev/mmcblk0 of=/media/partage/backup_img_pi/backup_pi-$date.img
			pigz /media/partage/backup_imp_pi/backup_test2.img
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
	func_time
	echo "Job started at $time"
	dd bs=4M if=/dev/mmcblk0 of=/media/partage/backup_img_pi/$name.img status=progress
	echo "Transfert complete. Start compression ..."
	sleep 2 
	pigz -v /media/partage/backup_img_pi/$name.img
	func_time_elapsed
	func_time
	echo "Compression complete ! Job finished at $time"
	echo "Time elapsed : $time_elapsed_h:$time_elapsed_m'$time_elapsed_s"
}


if [[ -z $1 ]] ; then
	func_print_help
else
	arg=$1
	func_check_args "$arg"
fi
