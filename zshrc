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
# export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
export EC2_HOME=/usr/local/amazon
export AWS_ELB_HOME=/usr/local/amazon
export EC2_PRIVATE_KEY=~/.ssh/ec2/x509-amazon-tools-pk.pem
export EC2_CERT=~/.ssh/ec2/x509-amazon-tools-public.pem
export AWS_CREDENTIAL_FILE=~/.ssh/aws-credentials.txt
export AWS_AUTO_SCALING_HOME=/usr/local/amazon
export AWS_CLOUDWATCH_HOME=/usr/local/amazon
export AWS_IAM_HOME=/usr/local/amazon/IAMCli
export PATH=$PATH:$AWS_IAM_HOME/bin
export AWS_CLOUDFORMATION_HOME=/usr/local/amazon/cloudformation
export PATH=$PATH:$AWS_CLOUDFORMATION_HOME/cloudformation/bin
export EC2_REGION=eu-west-1 # this is where we do most of our work, so set as our default
export EC2_URL=https://ec2.$EC2_REGION.amazonaws.com

# add Amazon API tools to path
export PATH=$PATH:/usr/local/amazon/bin

# new Amazon AWS CLI
export AWS_CONFIG_FILE=~/.aws/config
export AWS_DEFAULT_PROFILE=personal
export PATH="/usr/local/share/python:$PATH"

# for gem opener
export GEM_EDITOR="subl"

# for VIM
export EDITOR="subl -w"

# add path for Nginx
export PATH="/usr/local/sbin:$PATH"

## ECONSULTANCY
## CAMPFIRE Notifications for Econsultancy
export CAMPFIRE_TOKEN="`cat ~/.econ-ec2/campfire_token.txt`"
## Shortcut for connecting to MySQL production
alias econ-mysql='~/.econ-ec2/mysql-production.sh'
## Connect to a production server
alias econ-console="econ-env && ~/code/econsultancy/governor/bin/sshto production death_star worker1 'source /etc/profile && cd death_star/current && bundle exec rails console'"
## short cut to set up Econ env vars so that AWS credentials match
alias econ-env='source ~/.econ-ec2/env.sh'

# Prevent locale issues when SSH'ing into boxes
export LC_ALL=en_US.utf-8

# aliases
alias ssh-new='ssh -S none'
alias "ps?"="ps ax | grep -v grep | grep "
alias "ps!"="~/bin/kill-process-grep "
alias be='bundle exec'

# Boot2Docker
export DOCKER_HOST="localhost:4243"

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
