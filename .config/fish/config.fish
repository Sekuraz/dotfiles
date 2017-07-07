
abbr --add l. 'ls -la'
abbr --add ll 'ls -l'

set -g EDITOR 'vim'

# show state of git repo
set -g __fish_git_prompt_showcolorhints 'yes'
set -g __fish_git_prompt_color_branch 'normal'
set -g __fish_git_prompt_show_informative_status 'yes'

# disble shortening of paths
set -g fish_prompt_pwd_dir_length 0

# import virtualenvwrapper functions
if python -m virtualfish compat_aliases 1>/dev/null 2>/dev/null
    eval (python -m virtualfish compat_aliases)
end

if command -v screen >/dev/null ; and not hostname -f | grep login >/dev/null; and set -q SSH_TTY
    set -l screenlist (screen -ls | grep 'Attached')
    and echo -e "Screen is already running and attached:\n $screenlist"
    or screen -U -R
end
