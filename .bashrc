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
source /usr/share/gitstatus/gitstatus.prompt.sh

PS1='\[\e[32m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]: \[\e[37m\]\w\[\e[m\] ${GITSTATUS_PROMPT}\n\$ '

# https://www.reddit.com/r/vim/comments/morzue/vim_has_a_native_plugin_that_allows_you_to_turn/gu607ur?utm_source=share&utm_medium=web2x&context=3
# export MANPAGER="vim -M +MANPAGER --not-a-term -"
export MANWIDTH=80

# Colorful less

export LESS=' -R -j 8'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Eternal bash history
export HISTFILESIZE=
export HISTSIZE=
export HISTFILE=~/.bash_eternal_history
shopt -s histappend

# export EDITOR="vim"
export EDITOR='emacs -Q -nw --load "~/.nw_emacs"'
source /usr/share/chruby/chruby.sh
source /usr/share/chruby/auto.sh
chruby ruby-3.1.1

if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi

export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

export SDCV_PAGER='less --quit-if-one-screen -RX'
