#!/bin/sh
set -euf

if [ -z ${1+x} ]; then
  cmd='default'
else
  cmd="$1"
fi

binDir=$HOME/.local/bin
stuffDir=$HOME/.local/share/thoughts

if [ -d "$stuffDir" ]; then
    printf "Thoughts is already installed. Reinstall? [y/n]: "
    read -r reply
    if [ ! "$reply" = "y" ]; then
        echo
	echo "OK, nothing's been installed."
        exit 0
    fi
fi

mkdir -p "$stuffDir"/bin
cp parse.awk "$stuffDir"/bin
cp update.sh "$stuffDir"/bin
cp README.md "$stuffDir"
cp .head.html "$stuffDir"
cp .foot.html "$stuffDir"
cp thoughts-gitignore "$stuffDir"/.gitignore
touch "$stuffDir"/.rawthoughts.html

mkdir -p "$binDir"
cp thoughts "$binDir"
chmod +x "$binDir"/thoughts

if [ "$cmd" = "another" ]; then
    printf "What's the git clone URL for your existing thoughts repository?: "
    read -r reply
    git clone "$reply" "$stuffDir"/thoughts-temp
    cp -r "$stuffDir"/thoughts-temp/. "$stuffDir"
    rm -rf "$stuffDir"/thoughts-temp
    echo
    echo 'Done! Add $HOME/.local/bin to your PATH'
    exit 0
fi

echo
echo 'Done! Add $HOME/.local/bin to your PATH, and create a git repo: https://github.com/thwidge/thoughts#first-install'
