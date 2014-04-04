[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xscreensaver -no-splash -no-capture-stderr &
xcompmgr &
exec awesome
