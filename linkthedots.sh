#!/bin/bash

#script to copy the dotfiles to/from here to/from their proper places
#usage:
# $ sh linkthedots.sh collect --> get files
# $ sh linkthedots.sh push --> put files
# $ sh linkthedots.sh clean --> remove files

#get dotfiles dir path from running file
filepath=`readlink -f $0`;
rootdir=${filepath%/*};

#echo $rootdir;

case "$1" in
	'collect')
		echo "Collecting dotfiles..."
		#awesome
		cp -iruv ~/.config/awesome $rootdir/;
		#beets [only config file]
		cp -iruv ~/.config/beets/*.yaml $rootdir/beets/; #in case of multiple configs in folder
		#geany
		cp -iruv ~/.config/geany $rootdir/;
		#mpd
		#cp -iruv /media/xt1/BackThisUp/backup/music/mpd $rootdir/;
		cp -iruv /etc/mpd.conf $rootdir/mpd/;
		#ncmpcpp
		cp -iruv ~/.ncmpcpp $rootdir/;
		#mpv
		cp -iruv ~/.mpv $rootdir/;
		#gtk2-3
		cp -iruv ~/.config/gtk-2.0 $rootdir/;
		cp -iruv ~/.config/gtk-3.0 $rootdir/;
		cp -iruv ~/.gtk-bookmarks $rootdir/;
		cp -iruv ~/.gtkrc-2.0 $rootdir/;
		#git
		cp -iruv ~/.gitconfig $rootdir/;
		#shell - bash
		cp -iruv ~/.bash_history $rootdir/;
		cp -iruv ~/.bashrc $rootdir/;
		#Xsettings
		cp -iruv ~/.xinitrc $rootdir/;
		cp -iruv ~/.Xresources $rootdir/;
		cp -iruv ~/.xscreensaver $rootdir/;
		#file templates
		cp -iruv ~/Templates $rootdir/;
	;;
	
	'put')
		echo "Copying dotfiles to their proper locations..."
	;;
	*)
		echo "Usage:
$ sh linkthedots.sh collect --> get files
$ sh linkthedots.sh put --> put files
$ sh linkthedots.sh clean --> remove files"
esac
