# Define some functions for later usage
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

# If brew / rvm / node / npm isn't installed, install it
command -v brew >/dev/null 2>&1 || { echo "Homebrew not found. Installing." >&2; install_brew; }
command -v rvm >/dev/null 2>&1 || { echo "rvm not found. Installing." >&2; install_rvm; }
command -v node >/dev/null 2>&1 || { echo "node not found. Installing." >&2; install_node; }
command -v npm >/dev/null 2>&1 || { echo "npm not found. Installing." >&2; install_npm; }

# If the bucket directory doesn't exist, create it
if [[ ! -d "/usr/local/bucket" ]]; then
  mkdir /usr/local/bucket
fi

# Add autocomplete for Homebrew
source `brew --repository`/Library/Contributions/brew_bash_completion.sh

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin

# Load NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

# Export to PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/usr/local/bucket:$PATH

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
