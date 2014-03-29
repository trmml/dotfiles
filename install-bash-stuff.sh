#!/bin/bash

if [[ ! -d "/usr/local/bucket" ]]; then
  mkdir /usr/local/bucket
fi

curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/.bash_profile ~/.bash_profile
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/.bashrc ~/.bashrc
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/update.sh /usr/local/bucket/update
chmod +x /usr/local/bucket/update
