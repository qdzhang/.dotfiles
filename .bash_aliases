#-*- mode: shell-script -*-

alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lA'
# show entry in reverse date order
alias lsl='ls -lthra'
alias rm='printf "Use 'trash-put' to delete file.\nUse \\\rm for real rm.\n" | boxes -d stone; false'

alias dotfiles='/usr/bin/git --git-dir=/home/qdzhang/.dotfiles/ --work-tree=/home/qdzhang'
alias mvi='mpv --config-dir=$HOME/.config/mvi'

alias aur='auracle'

alias mptv='mpv --script-opts=iptv=1'
alias nv='nvim'
alias pmpv='prime-run mpv'

alias px='proxychains'

alias grep='grep --color'

alias k='kak'
# Use a shell wrapper to use this ee command
# alias ee='emacs -Q -nw --load "~/.nw_emacs"'
alias j='jmacs'
alias e='emacs'
alias proveall='prove -j9 --state=slow,save -lr t'
alias r='rails'
