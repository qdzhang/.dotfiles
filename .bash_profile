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

# if login in tty1, enter default wm (icewm)
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

# if login in tty2, enter i3wm
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 2 ]; then
  exec startx /usr/bin/i3
fi
