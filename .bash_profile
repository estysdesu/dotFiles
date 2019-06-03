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

# github.com/hkbakke/bash-insulter
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

# Golang
export GOPATH="${HOME}/localProjects/golang"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# add MOTD
sh /etc/motd.sh
