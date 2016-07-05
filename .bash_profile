if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [ -f ~/dotfiles/host_specific/`hostname -f`/bash_profile ]; then
    source ~/dotfiles/host_specific/`hostname -f`/bash_profile
fi
