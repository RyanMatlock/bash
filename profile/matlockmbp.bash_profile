export PATH=$HOME/Library/Haskell/bin:/usr/local/bin:$PATH
export LDFLAGS="-L/usr/local/include/c" # symlinked to
# /usr/local/Cellar/gcc49/4.9.0/lib/gcc/x86_64-apple-darwin13.3.0/4.9.0/include
# which is the gcc/g++49 library directory
export SUDO_PS1='\[\033[1;31m\][\u@\h] \W \$ \[\033[0m\]'

# fancy bash completion from
# $ brew install bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# turn on extended globs (so you can get the complement of a pattern or
# something like that)
shopt -s extglob

# ls, tree have color output enabled by default
alias ls='ls -G'
alias tree='tree -C'

# python3 -c 'from datetime import date; print("\n{} days until Fantabulon: "
#     "Glow!\n".format((date(2016,1,1)-date.today()).days))'

export TERM=xterm-256color
