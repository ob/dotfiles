#!/bin/bash

set -euo pipefail


if [[ ! -d "$HOME/dotfiles" ]]; then
    echo Clonning dotfiles and restarting
    git clone git@github.com:ob/dotfiles "$HOME/dotfiles"
    cd "$HOME/dotfiles"
    exec "$HOME/dotfiles/install.sh"
fi

if [[ $(pwd) != "$HOME/dotfiles" ]]; then
    echo "Re-running from $HOME/dotfiles"
    exec "$HOME/dotfiles/install.sh"
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
