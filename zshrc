ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=~/.dotfiles/oh-my-zsh/custom
ZSH_THEME="steeef_fork"

DISABLE_AUTO_UPDATE="true"
# DISABLE_LS_COLORS="true"

plugins=(git brew gem rbates)

export PATH="/usr/local/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# manually load RBates plugin allowing c shortcut to code folder in case it does not load above
source ~/.dotfiles/oh-my-zsh/custom/plugins/rbates/rbates.plugin.zsh

# amazon API tools
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home
export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.7.4.0

export EC2_REGION=eu-west-2 # this is where we do most of our work, so set as our default
export EC2_URL=https://ec2.$EC2_REGION.amazonaws.com

source ~/.ssh/aws-credentials-ably

# add Amazon API tools to path
export PATH=$PATH:$EC2_HOME/bin

# new Amazon AWS CLI
export AWS_CONFIG_FILE=~/.aws/config
export AWS_DEFAULT_PROFILE=personal
export PATH="/usr/local/share/python:$PATH"

# for gem opener
export GEM_EDITOR="subl"
export BUNDLE_EDITOR="subl"

# for VIM
export EDITOR="subl -n -w"

# add path for Nginx
export PATH="/usr/local/sbin:$PATH"

# Prevent locale issues when SSH'ing into boxes
export LC_ALL=en_US.utf-8

# aliases
alias ssh-new='ssh -S none'
alias "ps?"="ps ax | grep -v grep | grep "
alias "ps!"="~/bin/kill-process-grep "
alias be='bundle exec'

# Allow bin files in npm packages to be run
alias npm-exec='PATH=$(npm bin):$PATH'

# Boot2Docker - no longer used by default
# export DOCKER_HOST="10.124.11.2:2375"

# Git shortcuts
if [ ! -f /tmp/git_aliases_configured ]; then
  git config --global alias.g grep
  git config --global alias.a add
  git config --global alias.d diff
  git config --global alias.s status
  git config --global alias.c commit
  git config --global alias.l log
  git config --global alias.b branch
  git config --global alias.co checkout
  echo "Git aliases configured" > /tmp/git_aliases_configured
fi
alias g=git
alias z=zeus

# GS conflicts with Ghostscript
unalias gs

# Use Ctrl-F to delete the word to the right
bindkey "^F"  kill-word

# Clipper https://wincent.com/products/clipper (tmux copy & paste)
if [ ! `which clipper` ]; then
  echo "Warning: clipper is not installed.  Try brew install clipper"
fi
alias clip="nc localhost 8377"

# CTags, generate CTags from Gems
alias gem_ctags='generate_gem_ctags'

# Git up
git() {
  if ! which git-up > /dev/null 2>&1; then
    gem install git-up
  fi

  # workaround for https://github.com/aanand/git-up/blob/master/RVM.md
  if [[ $@ == "up" ]]; then
    command git-up
  else
    command git "$@"
  fi
}

# Ably run realtime core & front end in background processes on primary ports
alias run_core="~/code/Ably/realtime/core/main"
alias run_frontend="sudo WEBSOCKET_PORT=80 WEBSOCKET_TLS_PORT=443 ~/code/Ably/realtime/frontend/main"
test_api_key() {
  curl -s -X POST http://$1-rest.ably.io/apps -H "Content-Type: application/json" --data '{ "keys": [{}] }' | grep -E "id|scopeId|value" | tail -3
}

ably-env() {
  local cur_dir="$PWD"
  cd ~/code/Ably/infrastructure
  ~/code/Ably/infrastructure/bin/ably-env $@
  cd $cur_dir
}

ably() {
  ably-env $@
}

# Shortcut for git push deploy HEAD:production commonly used
deploy() {
  git push deploy HEAD:$@
}

# Go
export GOPATH=$HOME/go
# Bin executables for packages downloaded
export PATH="$GOPATH/bin:$PATH"

# add home bin
export PATH="/Users/$USER/bin:$PATH"

alias venv="source venv/bin/activate"

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# RbEnv
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# bin stubs
export PATH="./bin:$PATH"

# RVM
source ~/.rvm/scripts/rvm
