# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

##### MISC #####
set -o vi # set vi editing mode
export EDITOR=vim

HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history.
shopt -s histappend # append to the history file, don't overwrite it
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.

shopt -s globstar # If set, the pattern "**" used in a pathname expansion context will match all files and zero or more directories and subdirectories.

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" # make less more friendly for non-text input files, see lesspipe(1)

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# enable programmable completion features 
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# enable github.com/hkbakke/bash-insulter
if [ -f /etc/bash.command-not-found ]; then
	source /etc/bash.command-not-found
fi

##### EDIT PATH #####
export dotFiles="${HOME}/dotFiles"
path_munge_file="${dotFiles}/sbin/path_munge.sh"
if [ -f ${path_munge_file} ]; then
	source "${dotFiles}/sbin/path_munge.sh"
	path_munge "${HOME}/bin" before
	path_munge "${HOME}/.cargo/bin" after
	export GOPATH="${HOME}/.golang" after
	path_munge "${GOPATH}/.golang" after
	path_munge "${GOROOT}/.golang" after
	path_munge "${HOME}/.npm-global/bin" after
fi

##### PROMPT #####
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " # Bash prompt becomes (username@hostname:cwd$ )
export CLICOLOR=1 # bash prompt change to colorized
export LSCOLORS=exfxcxdxbxegedabagacad # default
export PROMPT_COMMAND="history -a;${PROMPT_COMMAND}"

# Execute MOTD
sh $HOME/bin/motd
