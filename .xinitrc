[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xscreensaver -no-splash -no-capture-stderr &
xcompmgr &
/usr/bin/start-pulseaudio-x11
exec awesome
