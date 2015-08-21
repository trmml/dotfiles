# Add autocomplete for Homebrew
source `brew --repository`/Library/Contributions/brew_bash_completion.sh

# Vim master race
export EDITOR="vim"

# Z
. `brew --prefix`/etc/profile.d/z.sh

# Add rbenv to the path
export PATH="$HOME/.rbenv/bin:$PATH"

# Add `rbenv init` for enabling shims & autocompletion
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
