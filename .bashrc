# Define some functions for later usage

update() {
  curl -Ls http://git.io/c9yaXQ | sh
  brew update
  brew upgrade
  n latest
  npm update -gs
  apm upgrade
  update_rubygems
  gem update --system
  gem update
  pip-review --auto
  keybase-installer
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

install_cowsay() {
  brew install cowsay
}

install_toilet() {
  brew install toilet
}

install_wget() {
  brew install wget
}

install_tree() {
  brew install tree
}

install_bower() {
  npm install -g bower
}

install_coffee() {
  npm install -g coffee-script
}

install_keybase() {
  npm install -g keybase-installer
  keybase-installer
}

install_n() {
  npm install -g n
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

package="cowsay"
function="install_cowsay"
install_package

package="toilet"
function="install_cowsay"
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

package="n"
function="install_n"
install_package

package=""
function=""

# If the bucket directory doesn't exist, create it
if [[ ! -d "/usr/local/bucket" ]]; then
  mkdir /usr/local/bucket
fi

if [[ ! -f "~/.hushlogin" ]]; then
  touch ~/.hushlogin
fi

#Define Aliases
alias ls="ls -FG"

# Add autocomplete for Homebrew
source `brew --repository`/Library/Contributions/brew_bash_completion.sh

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin

# Load NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

# Export to PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/usr/local/bucket:$PATH

# Colors
R="\[\033[0;31m\]" # red
B="\[\033[0;34m\]" # blue
C="\[\033[0;39m\]" # clear

# Custom PS1
export PS1="$B\u$C \w $R\$$C "

# Reset colors
R=""
W=""

# Make Terminal colorful
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
