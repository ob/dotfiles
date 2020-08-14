#!/bin/bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

test -d "$HOME/dotfiles" || {
    echo Clonning dotfiles and restarting
    git clone git@github.com:ob/dotfiles "$HOME/dotfiles"
    cd "$HOME/dotfiles"
    exec "$HOME/install.sh"
}

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
