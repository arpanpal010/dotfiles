#============================
# ~/.bashrc by DaWwG
#============================
#  This file is normally read by interactive shells only.
#+ Here is the place to define your aliases, functions and other interactive features like your prompt.
#  The majority of the code here assumes you are on a GNU system (most likely a Linux box) and is often based on code found on Usenet or Internet.
#
#  See for instance:
#  http://tldp.org/LDP/abs/html/index.html
#  http://www.caliban.org/bash
#  http://www.shelldorado.com/scripts/categories.html
#  http://www.dotfiles.org
#  http://www.debian-administration.org/articles/205
#  http://www.askapache.com/linux/bash-power-prompt.html
#  http://tldp.org/HOWTO/Bash-Prompt-HOWTO
#  https://github.com/nojhan/liquidprompt
#  https://wiki.archlinux.org/index.php/Color_Bash_Prompt

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then debian_chroot=$(cat /etc/debian_chroot); fi

#source global definitions if any
if [ -f /etc/bashrc ]; then . /etc/bashrc; fi    # --> Read /etc/bashrc, if present.

# enable programmable completion features (you don't need to enable this, if it's already enabled in /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then . /etc/bash_completion; fi

# prepend $HOME/bin to the path if it exists
if [ -e $HOME/bin ]; then export PATH=$HOME/bin:$PATH; fi

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"; fi

#shell variables
export BROWSER='firefox'
export PAGER=less
export LESS='-R'
export HISTCONTROL=ignoredups #ignore duplicate commands
export HISTSIZE=5000
export HISTFILESIZE=1000
export DISPLAY=:0.0

[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)" # make less more friendly for non-text input files, see lesspipe(1)


#stty -ixon		# disable XON/XOFF flow control (^s/^q) 
complete -cf sudo	# Tab complete for sudo

#shopt
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s histappend	# Append to history rather than overwrite
shopt -s checkwinsize	# Check window after each command
#shopt -s globstar # If set, the pattern "**" used in a pathname expansion context will match all files and zero or more directories and subdirectories.

## set options
set -o noclobber 	# prevent overwriting files with cat
#set -o ignoreeof	# stops ctrl+d from logging me out


# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#xterm)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#    ;;
#*)
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    ;;
#esac

BGREEN='\[\033[1;32m\]'
GREEN='\[\033[0;32m\]'
BRED='\[\033[1;31m\]'
RED='\[\033[0;31m\]'
BBLUE='\[\033[1;34m\]'
BLUE='\[\033[0;34m\]'
NORMAL='\[\033[00m\]'
#set prompt after checking user
if [ `id -un` = root ]; then PS1="${BGREEN}[${GREEN}\t${BGREEN} >> ${BRED}\u${BBLUE}@\h: ${NORMAL}\w${BGREEN}]\\n${BRED}#:${NORMAL}" #root
else PS1="${BGREEN}[${GREEN}\t${BGREEN} >> ${BBLUE}\u@\h: ${NORMAL}\w${BGREEN}]\\n\$:${GREEN}" #user
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Names of open files
alias lsofnames="lsof | awk '!/^\$/ && /\// { print \$9 }' | sort -u"

#safety! ohnoes.
#alias rm='rm -i'
#alias cp='cp -i'
#alias mv='mv -i'
#alias mkdir='mkdir -p'

#unicode
alias xterm='uxterm'
#alias screen='screen -U'
#sudo
#alias root='sudo su'

#pacman
alias pacman='pacman --color=always'
# Pacman alias examples
alias pacupg='sudo pacman -Syu'		# Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacin='sudo pacman -S'		# Install specific package(s) from the repositories
alias pacins='sudo pacman -U'		# Install specific package not from the repositories but from a file 
alias pacre='sudo pacman -R'		# Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'		# Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'		# Display information about a given package in the repositories
alias pacreps='pacman -Ss'		# Search for package(s) in the repositories
alias pacloc='pacman -Qi'		# Display information about a given package in the local database
alias paclocs='pacman -Qs'		# Search for package(s) in the local database
alias paclo="pacman -Qdt"		# List all packages which are orphaned
alias pacc="sudo pacman -Scc"		# Clean cache - delete all not currently installed package files
alias paclf="pacman -Ql"		# List all files installed by a given package
alias pacexpl="pacman -D --asexp"	# Mark one or more installed packages as explicitly installed 
alias pacimpl="pacman -D --asdep"	# Mark one or more installed packages as non explicitly installed
alias pacro="pacman -Qtdq > /dev/null && sudo pacman -Rns \$(pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')" # '[r]emove [o]rphans' - recursively remove ALL orphaned packages
# Additional pacman alias examples
alias pacupd='sudo pacman -Sy && sudo abs'         # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps'            # Install given package(s) as dependencies
alias pacmir='sudo pacman -Syy'                    # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist
#lock
alias pacunlock="sudo rm /var/lib/pacman/db.lck"   # Delete the lock file /var/lib/pacman/db.lck
alias paclock="sudo touch /var/lib/pacman/db.lck"  # Create the lock file /var/lib/pacman/db.lck

#other
alias bk='cd $OLDPWD'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias daemons='ls /var/run/daemons'
alias ping='ping -c 5'
alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'

alias extract='sh ~/bin/extract.sh' #runs extract.sh
alias hostinfo='sh ~/bin/hostinfo.sh' #runs hostinfo.sh

alias update='sudo pacman -Syu'

alias rpi='sh ~/bin/pi.sh' #runs pi.sh
alias vncstart='vncserver :1 -geometry 1280x720 -depth 16 -pixelformat rgb565' #start vncserver
alias vnckill='vncserver -kill :1'

alias awsetbg="sh ~/bin/awsetbg.sh"

alias note="python2.7 ~/bin/note.py"
alias medb="python2.7 ~/scrap/omdb/ui.py"

alias dxscr="xscreensaver-command --deactivate &"
alias axscr="xscreensaver-command --activate &"

