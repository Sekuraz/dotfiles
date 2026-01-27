
abbr --add l. 'ls -la'
abbr --add ll 'ls -l'

set -g EDITOR 'vim'

# show state of git repo
set -g __fish_git_prompt_showcolorhints 'yes'
set -g __fish_git_prompt_color_branch 'normal'
set -g __fish_git_prompt_show_informative_status 'yes'

# disble shortening of paths
set -g fish_prompt_pwd_dir_length 0

# start ssh-agent if there is none
ssh-agent >/dev/null

