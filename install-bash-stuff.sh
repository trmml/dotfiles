#!/bin/bash

currentdir=$(pwd)

if [[ ! -d "/usr/local/bucket" ]]; then
  mkdir /usr/local/bucket
fi

cd ~
 echo '
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting' > ~/.profile

curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/configs/.bash_profile >/dev/null 2>&1
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/configs/.bashrc >/dev/null 2>&1
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/configs/.aliases >/dev/null 2>&1
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/configs/.gitconfig >/dev/null 2>&1
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/configs/.vimrc >/dev/null 2>&1
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/configs/.gemrc >/dev/null 2>&1

cd $currentdir
source ~/.bash_profile
if [ ! gem spec rake > /dev/null 2>&1 ]; then
  gem install rake
fi

# Essentially installs all the gems
if [ -d ".something" ]; then
  rm -r .something
fi
mkdir .something
cd .something
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/Rakefile >/dev/null 2>&1
curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/Gemfile >/dev/null 2>&1
rake
cd ..
rm -r .something
. .bash_profile
echo "dotfiles have been updated"
