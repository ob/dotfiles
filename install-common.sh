#!/bin/bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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
if [[ ! -d "$HOME/.zprezto" ]]; then
    git clone --recursive https://github.com/ob/prezto.git "${HOME}/.zprezto"
else
    cd "$HOME/.zprezto"
    git pull
fi

for rcfile in "${HOME}"/.zprezto/runcoms/*; do
  rc=$(basename "$rcfile")
  test "$rc" = "README.md" && continue
  test -L "${HOME}/.${rc}" && continue
  test -f "${HOME}/.${rc}" && mv "${HOME}/.${rc}" "${HOME}/.${rc}.old"
  ln -s "$rcfile" "${HOME}/.${rc}"
done
