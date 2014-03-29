#!/bin/sh

#remove everything first
rvm implode
rm -r /usr/local/bucket

brew uninstall cmatrix cowsay hr toilet tree wget

#install rvm
\curl -L https://get.rvm.io | bash -s stable --ruby

#install brew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

#install brew pacakges
brew install cmatrix cowsay hr toilet tree wget

#update brew packages
brew update
brew upgrade

#install some apps
brew tap phinze/cask
brew install brew-cask
brew cask install google-chrome alfred f-lux dropbox vlc

#install node
brew install node --without-npm
curl -L https://npmjs.org/install.sh | sh

#install node packages
#add more options for keybase (keybase.io)
npm install -g coffee-script bower keybase-installer

#install rake and rake some stuff
gem install rake
rake
