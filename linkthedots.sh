#!/bin/bash

#script to copy the dotfiles to/from here to/from their proper places
#to clone: git clone https://github.com/arpanpal010/dotfiles.git
#usage:
# $ sh linkthedots.sh collect --> get files
# $ sh linkthedots.sh push --> put files
# $ sh linkthedots.sh clean --> remove files

#get dotfiles dir path from running file
filepath=`readlink -f $0`;
rootdir=${filepath%/*};
#echo $rootdir;

dotfileslist=( #write full paths of dotfile locations
	"/home/$USER/.config/awesome"
	"/home/$USER/.config/beets/config.yaml"
	"/home/$USER/.config/geany"
	"/home/$USER/.config/gtk-2.0"
	"/home/$USER/.config/gtk-3.0"
	"/home/$USER/.gtk-bookmarks"
	"/home/$USER/.gtkrc-2.0"
	"/home/$USER/.gitconfig"
	"/home/$USER/.bashrc"
	"/home/$USER/.bash_history"
	"/home/$USER/.xinitrc"
	"/home/$USER/.Xresources"
	"/home/$USER/.xscreensaver"
	"/home/$USER/Templates"
	"/etc/mpd.conf"
	#"/media/xt1/BackThisUp/backup/music/mpd"
	"/home/$USER/.ncmpcpp"
	"/home/$USER/.mpv"
	);

#functions
dot_collect(){ #collecting dotfiles from their locations to $rootdir
	echo "Collecting dotfiles...";
	for index in ${!dotfileslist[*]};
	do
		dotpath="${dotfileslist[$index]}";
		#echo $dotpath;
		dotfilename="${dotpath##*/}";
		dotlocation="${dotpath%/*}";
		#echo "$dotlocation/" "$dotfilename";
		cp -iruv "$dotlocation/$dotfilename" "$rootdir/";
	done;
}
dot_push(){ #pushing dotfiles from #rootdir to their actual locations
	echo "Copying dotfiles to their proper locations..."
	for index in ${!dotfileslist[*]};
	do
		dotpath="${dotfileslist[$index]}";
		#echo $dotpath;
		dotfilename="${dotpath##*/}";
		dotlocation="${dotpath%/*}";
		#echo "$dotlocation/" "$dotfilename";
		cp -iruv "$rootdir/$dotfilename" "$dotlocation/";
	done;
}
dot_cleanstore(){ #cleaning $rootdir
	echo "Cleaning files from $rootdir..."
	for index in ${!dotfileslist[*]};
	do
		dotpath="${dotfileslist[$index]}";
		#echo $dotpath;
		dotfilename="${dotpath##*/}";
		dotlocation="${dotpath%/*}";
		#echo "$dotlocation/" "$dotfilename";
		rm -Irfv "$rootdir/$dotfilename";
	done;
}
dot_cleanfiles(){ #removing dotfiles from their locations
	echo "Cleaning files from configs..."
	for index in ${!dotfileslist[*]};
	do
		dotpath="${dotfileslist[$index]}";
		#echo $dotpath;
		#dotfilename="${dotpath##*/}";
		#dotlocation="${dotpath%/*}";
		#echo "$dotlocation/" "$dotfilename";
		rm -Irfv "$dotpath";
	done;
}
dot_usage(){ #help
	echo "dotfiles storage-->$rootdir
Usage:
$ sh linkthedots.sh collect --> get files
$ sh linkthedots.sh push --> put files
$ sh linkthedots.sh cleanstore --> remove files from dotstorage
$ sh linkthedots.sh cleanfiles --> remove files from config locations
$ sh linkthedots.sh help --> show this help
";
}

#args
case "$1" in
	'collect') dot_collect;
	;;
	'push')	dot_push;
	;;
	'cleanstore') dot_cleanstore;
	;;
	'cleanfiles') dot_cleanfiles;
	;;
	'help') dot_usage;
	;;
	*) dot_usage;
	;;
esac
