# -*- mode: sh -*-
# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
# PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# Matlock's standard prompt
if [ "$TERM" = "dumb" ]; # (note bash's unusual string comparison operator)
then
    PS1='> '
else
    if [ $(id -u) -eq 0 ];
    then
        # if you're root, the prompt should be bold and red
        # PS1='[\h:\W \u] \$ '
        PS1='\[\033[1;31m\][\u@\h] \W \$ \[\033[0m\]'
    else
        # if you're not root, bold is fine
        PS1='\[\033[1;30m\][\u@\h:\W] \[\033[1;32m\]\$ \[\033[0m\]'
    fi
fi
if [ "$TERM" = "dumb" ]; # (note bash's unusual string comparison operator)
then
    PS1='> '
else
    if [ $(id -u) -eq 0 ];
    then
        # if you're root, the prompt should be bold and red
        # PS1='[\h:\W \u] \$ '
        PS1='\[\033[1;31m\][\u@\h] \W \$ \[\033[0m\]'
    else
        # if you're not root, bold is fine
        # you were using bright black before ([1;30m), but you should just use
        # bold, because bright black is too dark on non-Solarized Dark
        # terminals
        PS1='\[\033[1m\][\u@\h:\W] \[\033[1;32m\]\$ \[\033[0m\]'
    fi
fi

PS2='> '
PS3='> '
PS4='+ '

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ] && [ ! -e "$HOME/.hushlogin" ] ; then
    case " $(groups) " in *\ admin\ *)
    if [ -x /usr/bin/sudo ]; then
    cat <<-EOF
    To run a command as administrator (user "root"), use "sudo <command>".
    See "man sudo_root" for details.
    
    EOF
    fi
    esac
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
    function command_not_found_handle {
            # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
           /usr/bin/python /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
           /usr/bin/python /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
        else
           printf "%s: command not found\n" "$1" >&2
           return 127
        fi
    }
fi

# create a new timestamped document and open it in the editor of your choice
# (this is a bit of an improvement over past a past version of this you've
# made)
# references:
# flag arguments/case stuff:
# http://stackoverflow.com/questions/7069682/how-to-get-arguments-with-flags-in-bash-script
# checking if a variable is set (not done totally correctly, but when is
# $EDITOR really going to be empty?):
# http://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
# this works for Arch now at least -- we'll see about Elementary OS later
function func_tstxt {
    now=$(date +"%F-%H%M%S");
    if [ $# -eq 0 ];
    then
        if [ -z $EDITOR ];
        then
            vi $now.txt;
        else
            $EDITOR $now.txt;
        fi
    else
        case "$1" in
            -e|--emacs)
                emacs $now.txt;;
            -n|--nano)
                nano $now.txt;;
            -p|--pico)
                pico $now.txt;;
            -v|--vi|--vim)
                vi $now.txt;;
        esac
    fi
}

alias tstxt=func_tstxt
alias vtstxt="tstxt --vi"
