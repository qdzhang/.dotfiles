#-*- mode: shell-script -*-

# Use fzf to fuzzy find files in terminal
# find-in-file - usage: fif <SEARCH_TERM>
# from https://betterprogramming.pub/boost-your-command-line-productivity-with-fuzzy-finder-985aa162ba5d
fif() {
	if [ ! "$#" -gt 0 ]; then
		echo "Need a string to search for!"
		return 1
	fi
	rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}

# Use fzf to fuzzy find man pages
# https://github.com/junegunn/fzf/wiki/Examples#man-pages
fman() {
	man -k . | fzf -q "$1" --prompt='man> ' --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}

# A quick `cd` replacement
# https://einverne.github.io/post/2019/08/fzf-usage.html
fcd() {
	local dir
	dir=$(fd --follow --hidden --type directory --exclude node_modules --exclude .git | fzf +m) &&
		cd "$dir"
}

# Use fzf to show directories under current dir, and goto it
fls() {
	local dir
	dir=$(fd --follow --hidden --prune --type directory --exclude node_modules --exclude .git | fzf +m) &&
		cd "$dir"
}

# fkill - kill process
# https://einverne.github.io/post/2019/08/fzf-usage.html
fkill() {
	local pid
	pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

	if [ "x$pid" != "x" ]; then
		echo $pid | xargs kill -${1:-9}
	fi
}

defen() {
	sdcv -n --utf8-output --color "$@" 2>&1 |
		fold --width=$(tput cols) |
		less --quit-if-one-screen -RX
}

proxyon() {
	export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
	export http_proxy=http://127.0.0.1:7890
	export https_proxy=http://127.0.0.1:7890
	export all_proxy=socks5://127.0.0.1:7890
	export HTTP_PROXY=http://127.0.0.1:7890
	export HTTPS_PROXY=http://127.0.0.1:7890
	export ALL_PROXY=socks5://127.0.0.1:7890

	echo -e "\033[0;32m Proxy on ...\033[0m"
	# curl ifconfig.co/country
	curl ipinfo.io
}

proxyoff() {
	unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY all_proxy ALL_PROXY
	echo -e "\033[0;32m Proxy off ...\033[0m"
	# curl ifconfig.co/country
	curl ipinfo.io
}
