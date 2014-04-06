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
if [ ! gem spec rake > /dev/null 2>&1 ]; then
  gem install rake
fi

# Essentially installs all the gems
git clone https://github.com/trommel/dotfiles.git >/dev/null 2>&1
cd dotfiles
rake
cd ..
rm -r dotfiles
echo "dotfiles have been updated"
