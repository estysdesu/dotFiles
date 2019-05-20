# first source .bashrc
if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

# set vi editing mode
set -o vi

# bash prompt becomes [“username@hostname:cwd $”]
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# bash prompt change to colorized
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad # default
alias ls='ls -GFh'

# hide rm functionality to decrease bad habits
alias rm="echo Use 'trash' unless 'rm' is needed. If so, use the full path '/bin/rm' or '\rm'"

# add updatedb sys call by pointing symlink
[ -f /usr/local/bin/updatedb ] || ln -s /usr/libexec/locate.updatedb /usr/local/bin/updatedb 

# github.com/hkbakke/bash-insulter
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

# Golang
export GOPATH="${HOME}/localProjects/golang"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

# Ruby Version Manager
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# add MOTD
sh /etc/motd.sh
