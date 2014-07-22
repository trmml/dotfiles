# Define some functions

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
update() {
  cwd=$(pwd)
  cd ~
  #sudo softwareupdate -i -a -v
  curl -Ls http://git.io/c9yaXQ | sh
  brew update
  brew upgrade
  brew prune
  brew cleanup
  brew cask cleanup
  brew doctor
  brew cask doctor
  rvm get stable
  rvm reload
  curl -fsSL https://raw.github.com/supermarin/Alcatraz/master/Scripts/install.sh | sh
  npm update npm -g
  npm update -gs
  apm upgrade
  update_rubygems
  gem update
  gem update --system
  gem update
  rvm requirements
  pip install --upgrade setuptools
  pip install --upgrade pip
  heroku update
  keybase-installer
  if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
    git clone https://github.com/gmarik/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
    echo "$HOME/.vim/bundle/Vundle.vim has been created"
  fi
  . .bashrc
  cd $cwd
  #pip-review --auto
  #rm -rf ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/Alcatraz.xcplugin
  #rm -rf ~/Library/Application\ Support/Alcatraz
}

install_brew() {
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
}

install_rvm() {
  \curl -L https://get.rvm.io | bash -s stable --ruby
}

install_node() {
  brew install node --without-npm
}

install_npm() {
  curl -L https://npmjs.org/install.sh | sh
}

install_hr() {
  brew install hr
}

install_cmatrix() {
  brew install cmatrix
}

# install_cowsay() {
#   brew install cowsay
# }

# install_toilet() {
#   brew install toilet
# }

install_wget() {
  brew install wget
}

install_tree() {
  brew install tree
}

# install_bower() {
#   npm install -g bower
# }

install_coffee() {
  npm install -g coffee-script
}

install_keybase() {
  npm install -g keybase-installer
  keybase-installer
}

install_hub() {
  brew install hub
}

install_package() {
  command -v $package >/dev/null 2>&1 || { echo "$package not found. Installing." >&2; $function; }
}

# If [ package ] isn't installed, install it

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

# package="cowsay"
# function="install_cowsay"
# install_package

# package="toilet"
# function="install_cowsay"
# install_package

package="wget"
function="install_wget"
install_package

package="tree"
function="install_tree"
install_package

# package="bower"
# function="install_bower"
# install_package

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

# If the bucket directory doesn't exist, create it
if [[ ! -d "/usr/local/bucket" ]]; then
  mkdir /usr/local/bucket
fi

# If .hushlogin doesn't exist, create it
if [[ ! -f "~/.hushlogin" ]]; then
  touch ~/.hushlogin
fi


# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# Disable Dashboard
# defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
# defaults write com.apple.dock dashboard-in-overlay -bool true

# Add autocomplete for Homebrew
source `brew --repository`/Library/Contributions/brew_bash_completion.sh

# Load NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

# Export to PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/usr/local/bucket:$PATH
export PATH=/usr/local/bin/keybase:$PATH

# __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
# LAMBDA='λ'
# # Custom PS1
# export PS1="$B\u$C \w $G$__git_branch$R$LAMBDA $C"

# Colors
R="\[\033[0;31m\]" # red
G="\[\033[0;32m\]" # green
B="\[\033[0;34m\]" # blue
C="\[\033[0;39m\]" # clear

# __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
# LAMBDA='λ'
# # Custom PS1
# export PS1="$B\u$C \w $G$__git_branch$R$LAMBDA $C"

# Custom PS1
export PS1="$B\u$C \w$R λ $C"

# Casks Path
export CASKS_PATH="/usr/local/Library/Taps/caskroom/homebrew-cask/Casks/"

# Copy formula to my forked version
function copy_formula() {

  function help() {
    echo "You need to specify a Cask and a small amount of commit information."
    echo "ie: copy_formula popcorn-time \"[added|fixed] popcorn-time\""
  }

  # since bash is being weird
  # and won't let me do multiple if conditions
  if [ -z "$1" ]; then
     help
   elif [ -z "$2" ]; then
     help
   else
     current_dir=$(pwd)
     cp "$CASKS_PATH"/"$1.rb" \
       "$HOME/Dropbox/Developer/random stuff/homebrew-cask/Casks"
     cd "$HOME/Dropbox/Developer/random stuff/homebrew-cask"
     git add "Casks/$1.rb"

     if [[ "$1" == "added" ]]; then
       message="added $1 to Casks/"
     elif [[ "$2" == "fixed" ]]; then
       message="fixed $1"
     else
       message="I don't know"
     fi

     git commit -m "$message"
     git push
     cd $current_dir
     current_dir="" # reset! that!! variable!!!
   fi
}

# Makes a directory
# and `cd`s into it
# function mkdir-cd () {
#   mkdir "$1"
#   cd "$1"
# }

# Reset variables
R=
W=

if [[ ! -d "$HOME/go/src/github.com/trommel" ]]; then
  mkdir -p "$HOME/go/src/github.com/trommel"
  echo "$HOME/go/src/github.com/trommel has been created"
fi

# Set GOPATH and add it to $PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Make Terminal colorful
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
