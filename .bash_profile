#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

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

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.emacs.d/bin
export MOZ_X11_EGL=1
export EDITOR="vim"
export XSECURELOCK_BLANK_DPMS_STATE=off
export XSECURELOCK_COMPOSITE_OBSCURER=0
