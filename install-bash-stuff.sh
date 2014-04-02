#!/bin/bash

currentdir=$(pwd)

if [[ ! -d "/usr/local/bucket" ]]; then
  mkdir /usr/local/bucket
fi

cd ~
 echo '
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting' > ~/.profile

curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/.bash_profile >/dev/null 2>&1
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/.bashrc >/dev/null 2>&1
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/.aliases >/dev/null 2>&1

cd $currentdir
source ~/.bash_profile
echo "dotfiles have been updated"
