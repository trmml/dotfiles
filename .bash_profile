<<<<<<< HEAD
# Source files
. ~/.aliases
. ~/.profile
. ~/.bashrc
=======
# If files exist, source them
if [ -f ~/.profile ]; then . ~/.profile; fi
if [ -f ~/.aliases ]; then . ~/.aliases; fi
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
>>>>>>> FETCH_HEAD
