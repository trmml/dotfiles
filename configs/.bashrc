# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
update() {

  # Get current directory for later
  cwd=$(pwd)

  # `cd` into the home directory
  cd ~

  # Update Apple (App Store, mostly) Stuff
  # sudo softwareupdate -i -a -v

  # Update dotfiles unless the user specifies "--without-dotfiles-stuff" as an argument to the update function
  if [[ ! "$1" == "--without-dotfiles-stuff" ]]; then curl -Ls http://git.io/c9yaXQ | sh; fi

  # Update all Homebrew packages
  brew update
  brew upgrade

  # General Homebrew Cleanup
  brew prune
  brew cleanup
  brew cask cleanup

  # Update rvm
  rvm get stable

  # Install rvm requirements (this should only really need to happen once, but I might as well put it in here)
  rvm requirements

  # Reload rvm
  rvm reload

  # Install/Update Alcatraz
  curl -fsSL https://raw.github.com/supermarin/Alcatraz/master/Scripts/install.sh | sh

  # Update global npm packages
  npm update -g

  # Update Atom packages, and always say "yes" when asked if you would like to update said package/thing
  yes | apm upgrade

  # Update RubyGems (not to be confused with the gems that are installed)
  update_rubygems

  # Update Gems
  gem update

  # Update Heroku
  heroku update

  # Install/Update Keybase's CLI
  keybase-installer

  # Install Vundle if it's not already installed
  if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
    git clone https://github.com/gmarik/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
    echo "$HOME/.vim/bundle/Vundle.vim has been created"
  fi

  # Source .bashrc
  source .bashrc

  # `cd` back into the original directory
  cd $cwd

  # Update/Upgrade Pip
  # pip install --upgrade pip

  # Update/Upgrade Pip's setuptools
  # pip install --upgrade setuptools

  # Uninstall Alcatraz if the user specifies "--uninstall-alcatraz" as an argument to the update function
  if [ "$1" == "--uninstall-alcatraz" ]; then
    rm -rf ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/Alcatraz.xcplugin
    rm -rf ~/Library/Application\ Support/Alcatraz
  fi
}

# Install Brew
install_brew() {
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
}

# Install rvm
install_rvm() {
  \curl -L https://get.rvm.io | bash -s stable --ruby
}

# Install Node (without npm)
install_node() {
  brew install node --without-npm
}

# Install npm
install_npm() {
  curl -L https://npmjs.org/install.sh | sh
}

# Install hr
install_hr() {
  brew install hr
}

# Install cmatrix
install_cmatrix() {
  brew install cmatrix
}

# Install wget
install_wget() {
  brew install wget
}

# Install tree
install_tree() {
  brew install tree
}

# Install bower
install_bower() {
  npm install -g bower
}

# Install coffeescript
install_coffee() {
  npm install -g coffee-script
}

# Install the Keybase CLI
install_keybase() {
  npm install -g keybase-installer
  keybase-installer
}

# Install Hub
install_hub() {
  brew install hub
}

# Install `"$package"`
install_package() {
  command -v $package >/dev/null 2>&1 || { echo "$package not found. Installing." >&2; $function; }
}

# If `"$package"` isn't installed, install it

package="brew"
function="install_brew"
install_package

package="rvm"
function="install_rvm"
install_package

package="node"
function="install_node"
install_package

package="npm"
function="install_npm"
install_package

package="hr"
function="install_hr"
install_package

package="cmatrix"
function="install_cmatrix"
install_package

package="wget"
function="install_wget"
install_package

package="tree"
function="install_tree"
install_package

package="bower"
function="install_bower"
install_package

package="coffee"
function="install_coffee"
install_package

package="keybase-installer"
function="install_keybase"
install_package

package="hub"
function="install_hub"
install_package

# Reset variables
package=
function=

# Create ~/.hushlogin if it doesn't already exist
if [[ ! -f "~/.hushlogin" ]]; then
  touch ~/.hushlogin
fi

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# Add autocomplete for Homebrew
source `brew --repository`/Library/Contributions/brew_bash_completion.sh

# Load NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

# Export to PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/usr/local/bucket:$PATH
export PATH=/usr/local/bin/keybase:$PATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# Colors
R="\[\033[0;31m\]" # red
G="\[\033[0;32m\]" # green
B="\[\033[0;34m\]" # blue
C="\[\033[0;39m\]" # clear

# Lambda variable, obviously
LAMBDA='λ'

# Get current Git branch in Simple English
__git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'

# Custom PS1 (with Git branch in Simple English)
# Why won't the $R variable work, what the heck
export PS1="$B\u$C \w $G$__git_branch\[\033[0;31m\]$LAMBDA $C"

# Custom PS1
# export PS1="$B\u$C \w$R $LAMBDA $C"

# Casks Path
export CASKS_PATH="/usr/local/Library/Taps/caskroom/homebrew-cask/Casks/"

# Copy formula to my forked version
function copy_formula() {

  function help() {
    echo "You need to specify a Cask and a small amount of commit information."
    echo "ie: copy_formula \"[added|fixed] popcorn-time\""
  }

  # since bash is being weird
  # and won't let me do multiple if conditions
  if [ -z "$1" ]; then
     help
   elif [ -z "$2" ]; then
     help
   else
     current_dir=$(pwd)
     cp "$CASKS_PATH"/"$2.rb" \
       "$HOME/Dropbox/Developer/random stuff/homebrew-cask/Casks"
     cd "$HOME/Dropbox/Developer/random stuff/homebrew-cask"
     git add "Casks/$2.rb"

     if [[ "$1" == "added" ]]; then
       message="added $2 to Casks/"
     elif [[ "$1" == "fixed" ]]; then
       message="fixed $2"
     else
       message="I don't know"
     fi

     git commit -m "$message"
     git pull
     git push
     cd $current_dir
     message="" # reset! that!! variable!!!
     current_dir="" # reset! that!! variable!!!
   fi
}

function test_gem() {
  yes | gem uninstall "$1"
  gem build *gemspec*
  gem install ./*gem
  rm *gem
}

# For working with THEOS
export THEOS=/opt/theos
export THEOS_DEVICE_IP=bae-2.local THEOS_DEVICE_PORT=22

# Reset variables
R=
W=

# If the `"$GOPATH"` directories don't already exist, create them
if [[ ! -d "$HOME/.go/src/github.com/trommel" ]]; then
  mkdir -p "$HOME/.go/src/github.com/trommel"
  echo "$HOME/.go/src/github.com/trommel has been created"
fi

# Set GOPATH and add it to $PATH
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# Make Terminal colorful
# export CLICOLOR=1
# export LSCOLORS=GxFxCxDxBxegedabagaced

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
