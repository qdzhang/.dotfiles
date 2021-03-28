#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# PS1='[\u@\h \W]\$ '

# source ~/src/trueline/trueline.sh
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '
export GPG_TTY=$(tty)
source ~/gitstatus/gitstatus.prompt.sh

PS1='\[\e[32m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]: \[\e[37m\]\w\[\e[m\] ${GITSTATUS_PROMPT}\n\$ '
