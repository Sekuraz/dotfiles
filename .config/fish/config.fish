
abbr --add l. 'ls -lah'
abbr --add ll 'ls -lh'

ssh-agent >/dev/null

fish_add_path --path /home/markus/.local/bin /home/markus/.cargo/bin

# fish setup
set -g fish_greeting
set -g fish_prompt_pwd_full_dirs 100
set -g __fish_git_prompt_showcolorhints 1
set -g __fish_git_prompt_showupstream informative
set -g __fish_git_prompt_use_informative_chars 1
set -g __fish_git_prompt_showstashstate 1

# export computed hostname
set -x HOSTNAME $hostname

