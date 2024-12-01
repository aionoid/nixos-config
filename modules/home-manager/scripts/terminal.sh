#!/usr/bin/env bash

## launch terminal with alt config

if [ "$1" == "-f" ]; then
	kitty --app-id='kitty-float'
elif [ "$1" == "-F" ]; then
	kitty --start-as="fullscreen" --app-id='kitty-full' # --font="Iosevka Nerd Font:size=14" --override=pad=35x35
elif [ "$1" == "-s" ]; then
	kitty --app-id='kitty-float' \
	--window-size-pixels=$(slurp -b 20262CCC -c B4A1DBff -s B4A1DB0D -w 2 -f "%wx%h")
else
	kitty
fi
