#!/bin/bash

# If the dotfiles repo already exists, remove it
if [[ -d "dotfiles" ]]; then yes | rm -r dotfiles/; fi

# Clone the dotfiles repo and `cd` into it
git clone https://github.com/trommel/dotfiles
cd dotfiles/

# Enable copying all dotfiles from a directory, easily
shopt -s dotglob nullglob

# Move all of the config files to the home directory
mv configs/* ~

# Make sure everything is up to date now
source ~/.bash_profile

# Make sure everything is installed
# by running the update function
# (which is defined in .bashrc)
update

# If Rake isn't installed, install it
if [ ! gem spec rake > /dev/null 2>&1 ]; then gem install rake; fi

# `cd` into the general files directory
cd xfiles/

# Install everything from the general files
brew bundle
bundle install

# Get out of the dotfiles directory..
cd ../../

# ..and remove it
yes | rm -r dotfiles/

# Tell the user that everything is going to be OK
echo "dotfiles have been updated"
