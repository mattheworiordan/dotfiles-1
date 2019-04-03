ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=~/.dotfiles/oh-my-zsh/custom
ZSH_THEME="matt_simplified"

DISABLE_AUTO_UPDATE="true"

plugins=(git brew gem)

export PATH="/usr/local/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# c shortcut to code folder in case it does not load above
c() { cd ~/code/$1; }
_c() { _files -W ~/code -/; }
compdef _c c

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

# for Bash/ZSH
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

# Git shortcuts
if [ ! -f /tmp/git_aliases_configured ]; then
  git config --global alias.g grep
  git config --global alias.a add
  git config --global alias.d diff
  git config --global alias.s status
  git config --global alias.c commit
  git config --global alias.l log
  git config --global alias.b branch
  git config --global alias.bd "branch --sort=-committerdate"
  git config --global alias.co checkout
  echo "Git aliases configured" > /tmp/git_aliases_configured
fi
alias g=git
alias z=zeus

# Use Ctrl-F to delete the word to the right
bindkey "^F"  kill-word

# Clipper https://wincent.com/products/clipper (tmux copy & paste)
if ! which clipper > /dev/null 2>&1; then
  echo "Warning: clipper is not installed.  Try brew install clipper"
fi
alias clip="nc localhost 8377"

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

# Use Brew's OpenSSL as it supports Elliptic Curve encryption
export PATH="/usr/local/opt/openssl/bin:$PATH"

# Ably run realtime core & front end in background processes on primary ports
alias run_core="~/code/Ably/realtime/core/main"
alias run_frontend="sudo WEBSOCKET_PORT=80 WEBSOCKET_TLS_PORT=443 ~/code/Ably/realtime/frontend/main"
alias run_frontend_basic_auth="sudo ALLOW_BASIC_AUTH_WITHOUT_TLS=true WEBSOCKET_PORT=80 WEBSOCKET_TLS_PORT=443 ~/code/Ably/realtime/frontend/main"

# Ensure realtime logs with normal line breaks (these are not used in production to keep log lines together)
export LOG_HANDLER=raw

# Allow realtime to run whilst offline
# See https://github.com/ably/realtime/issues/2152
export DNS_RESOLVER=lookup

# Don't send Sentry errors from local CLI (useful if developing frequently)
export ABLY_ENV_SKIP_EXCEPTION_REPORTING=true

ably-env() {
  local cur_dir="$PWD"
  cd ~/code/Ably/infrastructure
  ~/code/Ably/infrastructure/bin/ably-env $@
  cd $cur_dir
}

ably() {
  ably-env $@
}

# Go
export GOPATH=$HOME/go
# Bin executables for packages downloaded
export PATH="$GOPATH/bin:$PATH"
# Support vendoring https://blog.gopheracademy.com/advent-2015/vendor-folder/
export GO15VENDOREXPERIMENT=1

# add home bin
export PATH="/Users/$USER/bin:$PATH"

alias venv="source venv/bin/activate"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# bin stubs
export PATH="./bin:$PATH"

# My secrets
source ~/.ssh/secret-envs

# Support QT and Capybara-webkit https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit
# export PATH="$(brew --prefix qt@5.5)/bin:$PATH"

# Iterm 2 integration
source ~/.iterm2_shell_integration.zsh

# Version managers

# Install ASDF version manager (multiple languages)
. $(brew --prefix asdf)/asdf.sh
. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash
