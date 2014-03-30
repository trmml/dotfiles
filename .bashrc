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
W="\[\033[0;39m\]" # white

# Clear
clear

# Custom PS1
export PS1="$B\u$W \w $R\$$W "

# Reset colors
R=""
W=""

# Make Terminal colorful
#export CLICOLOR=1
#export LSCOLORS=GxFxCxDxBxegedabagaced

# Load custom theme
#!/usr/bin/env bash
# Base16 Ocean - Gnome Terminal color scheme install script
# Chris Kempson (http://chriskempson.com)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Ocean Dark"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-ocean-dark"
[[ -z "$DCONF" ]] && DCONF=dconf
[[ -z "$UUIDGEN" ]] && UUIDGEN=uuidgen

dset() {
  local key="$1"; shift
  local val="$1"; shift

  if [[ "$type" == "string" ]]; then
	  val="'$val'"
  fi

  "$DCONF" write "$PROFILE_KEY/$key" "$val"
}

# because dconf still doesn't have "append"
dlist_append() {
  local key="$1"; shift
  local val="$1"; shift

  local entries="$(
    {
      "$DCONF" read "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
      echo "'$val'"
    } | head -c-1 | tr "\n" ,
  )"

  "$DCONF" write "$key" "[$entries]"
}

# Newest versions of gnome-terminal use dconf
if which "$DCONF" > /dev/null 2>&1; then
	[[ -z "$BASE_KEY" ]] && BASE_KEY=/org/gnome/terminal/legacy/profiles:

	if [[ -n "`$DCONF list $BASE_KEY/`" ]]; then
		if which "$UUIDGEN" > /dev/null 2>&1; then
			PROFILE_SLUG=`uuidgen`
		fi

    if [[ -n "`$DCONF read $BASE_KEY/default`" ]]; then
      DEFAULT_SLUG=`$DCONF read $BASE_KEY/default | tr -d \'`
    else
      DEFAULT_SLUG=`$DCONF list $BASE_KEY/ | grep '^:' | head -n1 | tr -d :/`
    fi

		DEFAULT_KEY="$BASE_KEY/:$DEFAULT_SLUG"
		PROFILE_KEY="$BASE_KEY/:$PROFILE_SLUG"

		# copy existing settings from default profile
		$DCONF dump "$DEFAULT_KEY/" | $DCONF load "$PROFILE_KEY/"

		# add new copy to list of profiles
    dlist_append $BASE_KEY/list "$PROFILE_SLUG"

		# update profile values with theme options
		dset visible-name "'$PROFILE_NAME'"
        dset palette "['#2b303b', '#bf616a', '#a3be8c', '#ebcb8b', '#8fa1b3', '#b48ead', '#96b5b4', '#c0c5ce', '#65737e', '#bf616a', '#a3be8c', '#ebcb8b', '#8fa1b3', '#b48ead', '#96b5b4', '#eff1f5']"
		dset background-color "'#2b303b'"
		dset foreground-color "'#c0c5ce'"
		dset bold-color "'#c0c5ce'"
		dset bold-color-same-as-fg "true"
		dset use-theme-colors "false"
		dset use-theme-background "false"

		exit 0
	fi
fi

# Fallback for Gnome 2 and early Gnome 3
[[ -z "$GCONFTOOL" ]] && GCONFTOOL=gconftool
[[ -z "$BASE_KEY" ]] && BASE_KEY=/apps/gnome-terminal/profiles

PROFILE_KEY="$BASE_KEY/$PROFILE_SLUG"

gset() {
  local type="$1"; shift
  local key="$1"; shift
  local val="$1"; shift

  "$GCONFTOOL" --set --type "$type" "$PROFILE_KEY/$key" -- "$val"
}

# Because gconftool doesn't have "append"
glist_append() {
  local type="$1"; shift
  local key="$1"; shift
  local val="$1"; shift

  local entries="$(
    {
      "$GCONFTOOL" --get "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
      echo "$val"
    } | head -c-1 | tr "\n" ,
  )"

  "$GCONFTOOL" --set --type list --list-type $type "$key" "[$entries]"
}

# Append the Base16 profile to the profile list
glist_append string /apps/gnome-terminal/global/profile_list "$PROFILE_SLUG"

gset string visible_name "$PROFILE_NAME"
gset string palette "#2b303b:#bf616a:#a3be8c:#ebcb8b:#8fa1b3:#b48ead:#96b5b4:#c0c5ce:#65737e:#bf616a:#a3be8c:#ebcb8b:#8fa1b3:#b48ead:#96b5b4:#eff1f5"
gset string background_color "#2b303b"
gset string foreground_color "#c0c5ce"
gset string bold_color "#c0c5ce"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
