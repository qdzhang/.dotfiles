#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Show an ascii art when bash start
# cat << "EOF"
#  _______
# < Hello >
#  -------
#        \   ^__^
#         \  (oo)\_______
#            (__)\       )\/\
#                ||----w |
#                ||     ||
# EOF

# PS1='[\u@\h \W]\$ '

# source ~/src/trueline/trueline.sh
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
# export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{node_modules/**,.git/**}"'
export GPG_TTY=$(tty)
source ~/gitstatus/gitstatus.prompt.sh

PS1='\[\e[32m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]: \[\e[37m\]\w\[\e[m\] ${GITSTATUS_PROMPT}\n\$ '

# https://www.reddit.com/r/vim/comments/morzue/vim_has_a_native_plugin_that_allows_you_to_turn/gu607ur?utm_source=share&utm_medium=web2x&context=3
export MANPAGER="vim -M +MANPAGER --not-a-term -"
export MANWIDTH=80

# Eternal bash history
export HISTFILESIZE=
export HISTSIZE=
export HISTFILE=~/.bash_eternal_history
shopt -s histappend

export EDITOR="vim"
eval "$(rbenv init -)"
