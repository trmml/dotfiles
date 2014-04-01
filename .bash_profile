$currentdir=$(pwd)
cd ~

# If files exist, source them
if [ -f ~/.profile ]; then
  . ~/.profile
else
  curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/.profile >/dev/null 2>&1
fi

if [ -f ~/.aliases ]; then
  . ~/.aliases
else
  curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/.bashrc >/dev/null 2>&1
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
else
  curl -O https://raw.githubusercontent.com/trommel/dotfiles/master/.aliases >/dev/null 2>&1
fi

cd $currentdir
