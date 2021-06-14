#!/bin/bash

set -euo pipefail

DOTFILES="$HOME/.dotfiles"

if [[ ! -d "$DOTFILES" ]]; then
    echo Clonning dotfiles and restarting
    git clone git@github.com:ob/dotfiles "$DOTFILES"
    cd "$DOTFILES"
    exec "$DOTFILES/install.sh"
fi

if [[ $(pwd) != "$DOTFILES" ]]; then
    echo "Re-running from $DOTFILES"
    cd "$DOTFILES"
    git pull
    exec "$DOTFILES/install.sh"
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
"$DIR/install-common.sh"

OS=$(uname -s)
case "$OS" in
    Linux)
        "$DIR/install-linux.sh"
        ;;
    Darwin)
        "$DIR/install-darwin.sh"
        ;;
    *)
        echo Unsupported
        exit 1
        ;;
esac
