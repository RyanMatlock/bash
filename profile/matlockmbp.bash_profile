export PATH=$HOME/Library/Haskell/bin:/usr/local/bin:$PATH
export LDFLAGS="-L/usr/local/include/c" # symlinked to
# /usr/local/Cellar/gcc49/4.9.0/lib/gcc/x86_64-apple-darwin13.3.0/4.9.0/include
# which is the gcc/g++49 library directory
export SUDO_PS1='\[\033[1;31m\][\u] \W \$ \[\033[0m\]'
