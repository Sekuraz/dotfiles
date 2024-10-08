# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


if [ -d "/usr/lib/ccache/bin/" ]; then
    export PATH="/usr/lib/ccache/bin/:$PATH"
fi

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(ssh-agent)
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [ $( command -v fish ) ]; then
    exec $( which fish )
fi

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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

[[ $COLORTERM = gnome-terminal && ! $TERM = screen-256color ]] && TERM=xterm-256color

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias l.='ls -al'

alias rm='rm -I'

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

export EDITOR=vim

# mkvirtualenv and others
if [ -f /etc/bash_completion.d/virtualenvwrapper ]; then
    export WORKON_HOME=~/.virtualenvs
    source /etc/bash_completion.d/virtualenvwrapper
fi

if [ -f /usr/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=~/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh
fi

# reattach to screen or start one if you connect via ssh
if [ $( command -v screen ) ] && [[ $(hostname) != *"login"* ]]; then
    if [ $SSH_TTY ] && [ ! $WINDOW ]; then
        if test "$SSH_AUTH_SOCK" ; then
            ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
        fi
        SCREENLIST=`screen -ls | grep 'Attached'`
        if [ $? -eq "0" ]; then
            echo -e "Screen is already running and attached:\n ${SCREENLIST}"
        else
            # screen -X setenv DISPLAY $DISPLAY
            screen -U -R
        fi
    fi
fi

# update and commit for svn
if [ $( command -v svn) ]; then
    alias svnci='svn up && svn ci'
fi

if [ $( command -v docker) ]; then
    alias bot='docker run -it -v /home/markus/Code/EarthLost:/EarthLost -w /EarthLost --rm --net="host" --user="$( id -u $USER ):$( id -g $USER )" --env="HOME=/EarthLost/docker/dockerhome" sekuraz/earthlost ipython'
fi

if [ -f ~/.ansible_pass ]; then
    export ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible_pass
fi
