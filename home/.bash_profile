if [ -f ~/.bashrc ]; then
  source ~/.bashrc
else
  echo "Error sourcing ~/.bashrc"
fi

if [ -f ~/.aliases ]; then
  source ~/.aliases
else
  echo "Error sourcing ~/.aliases"
fi
