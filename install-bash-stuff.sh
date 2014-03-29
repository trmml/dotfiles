#!/bin/bash

currentdir=$(pwd)

if [[ ! -d "/usr/local/bucket" ]]; then
  mkdir /usr/local/bucket
fi

cd ~

curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/.bash_profile >/dev/null 2>&1
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/.bashrc >/dev/null 2>&1

cd /usr/local/bucket

curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/update.sh >/dev/null 2>&1
mv update.sh update
chmod +x /usr/local/bucket/update

cd $currentdir

echo "dotfiles have been updated"
