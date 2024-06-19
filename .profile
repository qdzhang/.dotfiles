#
# ~/.profile
# https://superuser.com/questions/789448/choosing-between-bashrc-profile-bash-profile-etc
#

export PATH=$PATH:$HOME/.local/bin
# export PATH=$PATH:$HOME/.emacs.d/bin
export PATH=$PATH:$HOME/.npm_global/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/go/bin

export MOZ_X11_EGL=1
export XSECURELOCK_BLANK_DPMS_STATE=off
export XSECURELOCK_COMPOSITE_OBSCURER=0
# export QT_SCALE_FACTOR=1.2


# GTK-3 Scaling
GDK_SCALE=1.5 export GDK_SCALE
GDK_DPI_SCALE=1.5 export GDK_DPI_SCALE

# Qt5 Scaling
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCREEN_SCALE_FACTOR=2.0
export QT_SCALE_FACTOR=1.5
