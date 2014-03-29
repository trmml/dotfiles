source ~/.profile

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/usr/local/bucket:$PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
