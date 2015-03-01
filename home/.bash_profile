# There must be a better way of doing this

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

if [ -f ~/.profile]; then
  source ~/.profile
fi

if [ -f ~/.osx ]; then
  source ~/.osx
fi
