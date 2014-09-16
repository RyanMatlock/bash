# -*- mode: sh -*-
#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '

# # this actually seems to work nicely with Arch
# # source: 
# # http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html
# if [ $(id -u) -eq 0 ];
# then
#     # if you're root, the prompt should be bold and red
#     # PS1='[\h:\W \u] \$ '
#     PS1='\[\033[1;31m\][\u@\h] \W \$ \[\033[0m\]'
# else
#     # if you're not root, bold is fine
#     PS1='\[\033[1;30m\][\u@\h:\W] \[\033[1;32m\]\$ \[\033[0m\]'
# fi
# actually, it didn't work quite as nicely as I'd want -- it was causing TRAMP
# to hang
# see http://stackoverflow.com/questions/6954479/emacs-tramp-doesnt-work
# see also https://github.com/xaccrocheur/kituu/blob/master/.bashrc
if [ "$TERM" = "tramp" ]; # (note bash's unusual string comparison operator)
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

PS2='> '
PS3='> '
PS4='+ '

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
