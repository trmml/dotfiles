#!/bin/bash

# If the dotfiles repo already exists, remove it
if [ -d "dotfiles" ]; then yes | rm -r dotfiles/; fi

# Clone the dotfiles repo and `cd` into it
git clone https://github.com/trommel/dotfiles
echo "dotfiles/ directory successfully cloned"
cd dotfiles/
echo "changed into the dotfiles/ directory"

# Enable copying all dotfiles from a directory, easily
shopt -s dotglob nullglob

# Move all of the config files to the home directory
mv configs/* ~
echo "moved all of the config dotfiles into the home directory"

# Make sure everything is up to date now
source ~/.bash_profile
echo "sourced ~/.bash_profile"

# Make sure everything is installed
# by running the update function
# (which is defined in .bashrc)
echo "starting to update everything"
update --without-dotfiles-stuff # because we've already established the dotfiles stuff
echo "update complete"

# Tap my own cask so that I have access to my custom Casks
brew tap trommel/cask

# If Rake isn't installed, install it
if [ ! gem spec rake > /dev/null 2>&1 ]; then gem install rake; fi

# `cd` into the general files directory
cd xfiles/
echo "changed into the xfiles/ directory"

# Install everything from the general files
echo "installing everything from the general files.."
brew bundle
bundle install
echo "general file stuff has been installed"

# Get out of the dotfiles directory..
echo "getting out of the dotfiles/ directory"
cd ../../
echo "got out of the dotfiles/ directory"

# ..and remove it
yes | rm -r dotfiles/
echo "removed the dotfiles/ directory"

# Tell the user that everything is going to be OK
echo "dotfiles have been updated"
