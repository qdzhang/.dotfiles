alias ls='ls --color=auto'
alias la='ls -A'
alias rm='printf "Use 'trash-put' to delete file.\nUse \\\rm for real rm.\n" | boxes -d stone; false'

alias dotfiles='/usr/bin/git --git-dir=/home/qdzhang/.dotfiles/ --work-tree=/home/qdzhang'
alias mvi='mpv --config-dir=$HOME/.config/mvi'

alias aur='auracle'

alias mptv='mpv --script-opts=iptv=1'
alias nv='nvim'

alias ec='emacsclient -c'
alias et='emacsclient --tty'
