#!/bin/bash

set -euo pipefail

# Link dotfiles
for dotfile in "$DIR"/dotfiles/*
do
    # don't replace it if it's already there
    bn=$(basename "$dotfile")
    home_dotfile="$HOME/.$bn"
    test -f "$home_dotfile" -o -L "$home_dotfile" && continue
    ln -s "$dotfile" "$home_dotfile"
done

# set up zpresto
git clone --recursive https://github.com/ob/prezto.git "${HOME}/.zprezto"

for rcfile in "${HOME}"/.zprezto/runcoms/*; do
  test "$(basename $rcfile)" = "README.md" && continue
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
