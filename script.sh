#!/bin/bash


session="$DESKTOP_SESSION"

if [ $session != "xfce" ]; then
	echo "Error: not in xfce session."
	echo "exiting..."
	exit 1
fi

echo "WARNING: This script will replace current xfce4 configuration!!"
echo "*****************************"
echo "* xfce4-theme-andydevs69420 *"
echo "*****************************"
echo "Dependencies:"
echo "    [1]. xfce4-power-manager"
echo "    [2]. alsa-base"
echo "    [3]. pavucontrol"
echo "    [4]. volumeicon-alsa"
echo "    [5]. orage"
echo "    [6]. nomacs"
echo "    [7]. fonts-noto"
echo "    [8]. fonts-noto-color-emoji"
echo "    [9]. neofetch"
echo "Other dependencies:"
echo "    [1]. Papirus-Icons"
echo "    [2]. DragonCursors"
echo "    [3]. Volantes cursors"
echo "    [4]. Ark themes"
echo "-----------------------------"
echo "Github: https://github.com/andydevs69420/xfce4-theme-andydevs69420.git"
echo 

if ! [ $(id -u) = 0 ]; then
   	echo "Error: please run this script as sudo."
	echo "exiting..."
   	exit 1
fi


echo -n "Username: "
read username

distro="$(lsb_release -is)"
confpath="/home/$username/.config"

if getent passwd $username > /dev/null 2>&1; then
    	if [ "$distro" = "Ubuntu" ] || [ "$distro" = "Xubuntu" ] ; then
		#******* dependencies *******
		apt-get update
		apt-get install xfce4-power-manager -y
		apt-get install alsa-base -y
		apt-get install pavucontrol -y
		apt-get install volumeicon-alsa -y
		apt-get install orage -y
		apt-get install nomacs -y
		apt-get install fonts-noto
		apt-get install fonts-noto-color-emoji -y
		apt-get install neofetch -y
		neofetch
		#*********** files **********
		echo "Copying files..."
		cp -r Wallpapers/* /usr/share/backgrounds/xfce
		cp -r ArcTheme/* /usr/share/themes
		cp -r Papirus-Icon/* /usr/share/icons
		cp -r Cursors/* /usr/share/icons
		#********** updates *********
		echo "Updating cache..."
		gtk-update-icon-cache -f /usr/share/icons/*
		# fix volumeicon if running
		echo "Updating xfce..."
		rm -rf $confpath/xfce4
		cp -r NewConf/* $confpath
		#****************************
		echo -n "restart now?(y/n): "
		read opt
		if [ "$opt" = "y" ] || [ "$opt" = "Y" ]; then
			reboot now
		fi
	else
		echo "Error: unsupported distribution \"$distro\"."
		echo "exiting..."
		exit 1
	fi
	echo "Done!"
	echo "Please reboot your device."
	exit 1
else
    	echo "Error: user \"$username\" does not exist."
	echo "exiting..."
    	exit 1
fi






