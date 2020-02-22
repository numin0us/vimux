# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

PATH="/snap/bin:$PATH"
PATH="/home/adi/.local/bin:$PATH"
PATH="/home/adi/.local/share/applications:$PATH"
PATH="/home/adi/.cargo/bin:$PATH"


#Custom Apps
PATH="/home/adi/.joplin:$PATH" #Joplin
#PATH="/home/adi/.local/bin/kanboard:$PATH" #Kanboard
#PATH="/home/adi/.local/bin/proxmox:$PATH" #Proxmox
#PATH="/home/adi/.local/bin/ghidra:$PATH" #Proxmox
#PATH="/home/adi/.local/bin/monero:$PATH" #Proxmox
EDITOR=/usr/bin/vim
GIT_EDITOR=vim
VISUAL=vim
XDG_CONFIG_HOME=~/.config

#Android paths
PATH="/home/adi/Android/Sdk/platform-tools:$PATH"
PATH="/home/adi/Android/Sdk/tools:$PATH"
PATH="/home/adi/Android/Sdk/tools/bin:$PATH"
PATH="/home/adi/Android/Sdk/build-tools/29.0.1:$PATH"

ANDROID_SDK_ROOT="/home/adi/Android/Sdk/tools"
NDK="/home/adi/Android/Sdk/ndk-bundle"

source ~/.vim/bundle/gruvbox/gruvbox_256palette.sh


#/usr/bin/keychain --clear $HOME/.ssh/id_rsa
#source $HOME/.keychain/$HOSTNAME-sh

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
#alias start-pwntainer='docker run -d --rm --name pwntainer -p 127.0.0.1:1337:22 -v "/home/adi/storage/pwntainer:/pwntainer" --security-opt="seccomp=unconfined" --security-opt="apparmor=unconfined" --cap-add=SYS_PTRACE pwntainer'
alias start-pwntainer='docker run -d --rm --name pwntainer -p 127.0.0.1:1337:22 -v "/home/adi/storage/pwntainer:/pwntainer" --security-opt seccomp=unconfined --security-opt apparmor=unconfined --cap-add=SYS_PTRACE pwntainer'
alias stop-pwntainer='docker stop pwntainer'
alias restart-pwntainer='docker restart pwntainer'
alias pwntainer='ssh -o "StrictHostKeyChecking=no" root@localhost -p 1337 -t tmux new-session -A -s pwntainer'
alias start-pwntainer-xenial='docker run -d --rm --name pwntainer-xenial -p 127.0.0.1:1338:22 -v "/home/adi/storage/pwntainer:/pwntainer" --security-opt seccomp=unconfined --security-opt apparmor=unconfined --cap-add=SYS_PTRACE pwntainer-xenial'
alias stop-pwntainer-xenial='docker stop pwntainer-xenial'
alias restart-pwntainer-xenial='docker restart pwntainer-xenial'
alias pwntainer-xenial='ssh -o "StrictHostKeyChecking=no" root@localhost -p 1338 -t tmux new-session -A -s pwntainer-xenial'

function qira() {
	#echo "qira $1"
	docker run -p 127.0.0.1:3002:3002 -it qira /bin/bash -c "qira $1"
	firefox localhost:3002
}


#vi mode
set -o vi



[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval $(keychain --eval id_rsa)

source /home/adi/.config/broot/launcher/bash/br
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
