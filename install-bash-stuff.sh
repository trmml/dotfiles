#!/bin/bash

if [[ ! -d "/usr/local/bucket" ]]; then
  mkdir /usr/local/bucket
fi

curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/.bash_profile ~/.bash_profile >/dev/null 2>&1
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/.bashrc ~/.bashrc >/dev/null 2>&1
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/update.sh /usr/local/bucket/update >/dev/null 2>&1
chmod +x /usr/local/bucket/update
