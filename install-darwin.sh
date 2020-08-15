#!/bin/bash

set -euo pipefail

msg_status() {
  printf "\033[0;32m-- %s\033[0m\n" "$1"
}

msg_error() {
  printf "\033[0;31m-- %s\033[0m\n" "$1"
}

command -v brew >/dev/null 2>&1 || {
  msg_status "Installing HomeBrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

msg_status "Installing necessary fonts"
brew tap homebrew/cask-fonts
brew cask install font-fira-code font-inconsolata font-hack

msg_status "Installing brew packages"
brew install global htop jq ripgrep shellcheck
