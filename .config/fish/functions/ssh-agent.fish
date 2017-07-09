# Defined in /tmp/fish.0i9BEC/ssh-agent.fish @ line 2
function ssh-agent
	set -q SSH_AGENT_PID                                    # check whether we have a agent pid
    and ps -p $SSH_AGENT_PID >/dev/null                     # check whether it is active
    and test (ps -p $SSH_AGENT_PID -o cmd=) = "ssh-agent"   # and the right process
    and set -q SSH_AUTH_SOCK                                # we also need this variable to be set
    and echo "Agent already running, exiting"
    and return

    # this is a gnome session keyring
    string match -q "/run/user/"(id -u)"/keyring/ssh" $SSH_AUTH_SOCK
    and echo "You are using gnome session keyring, exiting"
    and return

    for pid in (ps -C ssh-agent -o pid=)
        kill $pid
    end

    set -l output (command ssh-agent)
    echo $output

    for line in $output
        set -l data (string split -m 1 ';' $line | head -n 1)
        string match -q -e SSH $data
        and set -l kv (string split '=' $data)
        and set -x -U $kv[1] $kv[2]
	end

    # for the return value to be correct
	set -q SSH_AGENT_PID                                    # check whether we have a agent pid
    and ps -p $SSH_AGENT_PID >/dev/null                     # check whether it is active
    and test (ps -p $SSH_AGENT_PID -o cmd=) = "ssh-agent"   # and the right process
    and set -q SSH_AUTH_SOCK                                # we also need this variable to be set
    and echo "Started ssh agent" >&2
    or echo "Failed to start ssh agent" >&2
end
