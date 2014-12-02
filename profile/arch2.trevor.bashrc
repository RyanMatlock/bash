#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# source /etc/bash.bashrc

# Trevor, you'll just have to deal with this:
# I'm now being prompted for my ssh password, so let's just start ssh-agent on
# login and get the password each time---annoying, but better than the
# alternative
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_rsa
# scratch the above
# ---now just call "rsa-ssh"
