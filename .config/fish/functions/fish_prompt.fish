function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

	set -l normal (set_color normal)

	set -l color_cwd

    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        else
            set color_cwd $fish_color_cwd
        end
        set suffix '#'
    else
        set color_cwd $fish_color_cwd
        set suffix '>'
    end

    printf '%s' (set_color $fish_color_user) "$USER" $normal
    printf '@'
    printf '%s' (set_color $fish_color_host) "$hostname" $normal
    printf ' '

    if test $VIRTUAL_ENV
        printf '(%s) ' (basename "$VIRTUAL_ENV")
    end

    printf '%s' (set_color $color_cwd) (prompt_pwd) $normal

    printf '%s ' (fish_vcs_prompt)

    printf '%s' $normal

	if test $last_status -ne 0
		printf '%s ' (set_color $fish_color_status) "[$last_status]" "$normal"
	end

    printf "\n$suffix "
end
