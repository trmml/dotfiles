# Add autocomplete for Homebrew
source `brew --repository`/Library/Contributions/brew_bash_completion.sh

# Vim master race
export EDITOR="vim"

# Z
. `brew --prefix`/etc/profile.d/z.sh

# Add rbenv to the path
export PATH="$HOME/.rbenv/bin:$PATH"

# Colors
R="\[\033[0;31m\]" # red
G="\[\033[0;32m\]" # green
B="\[\033[0;34m\]" # blue
M="\[\033[0;35m\]" # magenta
CYAN="\[\033[0;36m\]"
C="\[\033[0;39m\]" # clear

# Heart variable, obviously
HEART='♥'

# Get current Git branch in Simple English
__git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'

# Custom PS1 (with Git branch in Simple English)
# Why won't the $R variable work, what the heck
export PS1="\[\033[0;31m\]\u$C in $CYAN\w$C $G$__git_branch\[\033[0;31m\]$HEART$C "

# Add `rbenv init` for enabling shims & autocompletion
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
