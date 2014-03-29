#!/bin/bash

brew update
brew upgrade
npm update -gs
apm upgrade
update_rubygems
gem update --system
gem update
pip-review --auto
keybase-installer
