#!/bin/sh
if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile" ]; then
	. "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile"
else
	. "$HOME/.xprofile"
fi

# optimus
if [ -x $(command -v optimus-manager) ]; then
	sudo prime-switch
	prime-offload
fi

wal -R
ssh-agent awesome
