#!/bin/zsh

alias ts='tig status'
alias eft='ember exam --split=2 --parallel --silent'
alias git-track='function _gittrack(){ git branch --set-upstream-to=origin/"$1" "$1";};_gittrack'
alias pr='hub pull-request'
alias push='git publish'
alias pull='git pul'
alias gmm='git fetch && git rebase origin/master'
alias gcm='git checkout master'

# runs the django server, takes a single argument for the environment to use
# checks if manage.py is nested in the src directory or not
function runs() {
  NESTED_FILE=./src/manage.py
  cd .
  source deactivate
  source activate $(basename $PWD)
  if [[ -f "$NESTED_FILE" ]]; then
      ./src/manage.py ${1-remote_staging} runserver
  else
      ./manage.py ${1-remote_staging} runserver
  fi
}

# updates machine stuff like homebrew, global npm, and vim plugins
function update() {
  if [ "$(uname)" = "Darwin" ]; then
      brew update
      brew upgrade
      brew cleanup -s
      npm update -g
      vim +PlugInstall +qall # incase any plugins haven't been installed yet (new machine?)
      vim +PlugUpdate +qall
      vim +PlugUpgrade +qall
  else
      sudo apt-get update && sudo apt-get upgrade
      npm update -g
      vim +PlugInstall +qall # incase any plugins haven't been installed yet (new machine?)
      vim +PlugUpdate +qall
      vim +PlugUpgrade +qall
  fi
}
