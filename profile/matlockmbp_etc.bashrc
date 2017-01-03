# -*- mode: sh -*-
### if you're having trouble editing this file, try doing
### $ sudo chmod +w /etc/bashrc

# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# PS1='\h:\W \u\$ '

# source: 
# http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html
# if [ $(id -u) -eq 0 ];
# then
#     # if you're root, the prompt should be bold and red
#     # PS1='[\h:\W \u] \$ '
#     PS1='\[\033[1;31m\]\]\h:\W \u \$ \[\033[0m\]\]'
# else
#     # if you're not root, bold is fine
#     # PS1='\[\033[1;30m\]\]\h:\W \u \[\033[1;32m\]\$ \[\033[0m\]\]'
#     PS1='\[\033[1;30m\]\][\u@\h:\W] \[\033[1;32m\]\$ \[\033[0m\]\]'
# fi

# root user
# SUDO_PS1='\[\033[1;31m\]\]\h:\W \u \$ \[\033[0m\]\]'
# the one for root doesn't seem to be working
# SUDO_PS1='\[\033[1;31m\]\u \W \$ \[\033[0m\]'
# ...still not working
# source:
# http://www.macworld.com/article/1146550/rootprompt.html
# maybe I just need to edit my ~/.bash_profile instead

# # everyone else
# # PS1='\[\033[1;30m\]\][\u@\h:\W] \[\033[1;32m\]\$ \[\033[0m\]\]'
# # the \[ \] brackets seem to do a weird thing with line breaking
# # ok, I got it working -- you were already closing stuff with \], but you
# # needed to preceed the special, non-printed chars with \[
# # see
# # http://askubuntu.com/questions/24358/how-do-i-get-long-command-lines-to-wrap-to-the-next-line
# PS1='\[\033[1;30m\][\u@\h:\W] \[\033[1;32m\]\$ \[\033[0m\]'

# Matlock's standard command prompt
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

# Make bash check its window size after a process completes
shopt -s checkwinsize
# Tell the terminal about the working directory at each prompt.
if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.
    local SEARCH=' '
    local REPLACE='%20'
    local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
    printf '\e]7;%s\a' "$PWD_URL"
    }
    PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
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

export PATH=/usr/texbin:$PATH
# adding . to PYTHONPATH is useful for py.test (among other things)
export PYTHONPATH=$PYTHONPATH:.

# add Inkscape to command line
# http://wiki.inkscape.org/wiki/index.php/Mac_OS_X#Inkscape_command_line
alias inkscape="/Applications/Inkscape.app/Contents/Resources/bin/inkscape"

stty kill ^U; stty erase ^?
