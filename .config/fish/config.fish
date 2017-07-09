
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
command -v python >/dev/null
and python -m virtualfish compat_aliases >/dev/null ^/dev/null
and eval (python -m virtualfish compat_aliases)

# start ssh-agent if there is none
ssh-agent >/dev/null

# attach to screen or start a new one
if command -v screen >/dev/null ; and not hostname -f | grep login >/dev/null; and set -q SSH_TTY
    set -l ppid (string trim (ps --pid %self -o ppid=))
    while true
        if test $ppid = '1'
            set -l screenlist (screen -ls | grep 'Attached')
            and echo -e "Screen is already running and attached:\n $screenlist"
            or screen -U -R
            break
        end

        if string match -q -e 'SCREEN' (ps --pid $ppid -o cmd=)
            break
        end

        set -l ppid (string trim (ps --pid $ppid -o ppid=))
    end

    set -e ppid
end
