ZSH=$HOME/.oh-my-zsh
ZSH_THEME="steeef"
DISABLE_AUTO_UPDATE="true"
# DISABLE_LS_COLORS="true"

plugins=(git brew gem rbates)

export PATH="/usr/local/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# manually load RBates plugin allowing c shortcut to code folder in case it does not load above
source ~/.dotfiles/oh-my-zsh/custom/plugins/rbates/rbates.plugin.zsh

# for Homebrew installed rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# amazon API tools
export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
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

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Boot2Docker
export DOCKER_HOST="127.0.0.1:4343"

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

# CTags, generate CTags from Gems
alias gem_ctags='~/.dotfiles/scripts/generate_gem_ctags'

# add home bin
export PATH="/Users/$USER/bin:$PATH"

# bin stubs
export PATH="./bin:$PATH"

# RVM
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# NVM
source ~/.nvm/nvm.sh
