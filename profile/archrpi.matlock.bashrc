#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '

# added these to /etc/bash.bashrc to make available to all users
# export PATH=~/magzor/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl
# alias goodbye='systemctl poweroff'

# I'm now being prompted for my ssh password, so let's just start ssh-agent on
# login and get the password each time---annoying, but better than the
# alternative
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_rsa
# ok, I can deal with this (and I guess Trevor will have to, too)
# this seems to need to live here in order to not make logging in
# through Tramp super annoying/difficult/potentially impossible (I've
# already tried it in /etc/bash.bashrc)
# scratch the above
# ---now just call "rsa-ssh"
