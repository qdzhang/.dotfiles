#
# ~/.bash_profile
#

if [[ $(tty) = /dev/tty1 ]] ; then
    setfont ter-132n
fi

append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

[[ -f ~/.profile ]] && . ~/.profile
[[ -f ~/.bashrc ]] && . ~/.bashrc
