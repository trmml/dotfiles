if [ -f ~/.bashrc ]; then
  source ~/.profile
  echo '
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting' > ~/.profile
  source ~/.bashrc
fi
