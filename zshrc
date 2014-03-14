source ~/.aws/dev_credentials

if [ -f ~/.bash_profile ]; then
  . ~/.bash_profile
fi


###################
# ALIASES
###################

alias ..='cd ..'
alias l='ls'

alias r='cd ~/repos'
alias rd='cd ~/repos/delphi-reporter' 
alias ofe='cd ~/repos/ooyala/ofe/ooyala-web-rails'

alias sublime='open /Applications/Sublime\ Text\ 2.app/'

alias sb='source ~/.bashrc'
alias vb='vi ~/.bashrc'
alias vbp='vi ~/.bash_profile'

alias sub='subl ~/.bashrc'
alias subp='subl ~/.bash_profile'

alias subz='subl ~/.zshrc'
alias sz='source ~/.zshrc'

alias pull_analytics_repos='cd ~/repos/delphi-reporter; git pull; cd ~/repos/pingd; git pull; cd ~/repos/minerva; git pull; cd ~/repos/rookery; git pull; cd ~/repos/analytics-aggregates; git pull'

alias g='git'
alias gb='git branch'
alias gs='git status'
alias gp='git pull'
alias gc='git clone'
alias pg='git push'
alias gd='git diff --color-words'

alias be='bundle exec'
alias bi='bundle install'

alias dreporter='cd ~/repos/delphi-reporter; be guard;'
alias djasmine='cd ~/repos/delphi-reporter; be rake jasmine;'

alias sa='sbt assembly'
alias sc='sbt clean'
alias scb='sbt clean; sbt assembly'

alias jirash='$HOME/jirash/bin/jirash'
# complete -C 'jirash --bash-completion' jirash

alias kp='kill -9'

alias load-provider=~/repos/database-migrations/tools/load-provider.rb

alias ls="ls -G"
alias ll="ls -la"

# alias ssh=~/bin/ssh-host-color

###################
# FUNCTIONS
###################

gclone() {
   if [ ! "$1" == "-local"  ]; then
      cd $HOME/repos
      git clone "ssh://git@git.corp.ooyala.com/$1"
   else
      git clone "ssh://git@git.corp.ooyala.com/$2"
   fi   
}

gremote() {
   git checkout --track -b $1 origin/$1
}

# repeat() {
#     n=$1
#     shift
#     while [ $(( n -= 1 )) -ge 0 ]
#     do
#         "$@"
#     done
# }

function myprov {
  # Try matching the provider id first, then pcode
  output=`mysql -uroot vstreams -t -e "select users.id as user_id,email,users.permission as perm,api_key,provider_id as prov_id,master_provider_id as mstr_id,package_id,processing_profile_id as pp_id,reseller_id as r_id from users,providers,packages where providers.id=$1 and provider_id=providers.id and providers.package_id=packages.id order by perm,email" 2>/dev/null`
  if [ -n "$output" ]; then
    echo "$output"
  else
    mysql -uroot vstreams -t -e "select users.id as user_id,email,users.permission as perm,api_key,provider_id as prov_id,master_provider_id as mstr_id,package_id,processing_profile_id as pp_id,reseller_id as r_id from users,providers,packages where providers.pcode=\"$1\" and provider_id=providers.id and providers.package_id=packages.id order by perm,email"
  fi
}

function title { echo -ne "\033]0;$1\007"; }

# decrypt b64 strings, for example URLS passed to html5
# usage: b64 aHR0cDovL3BsYXllci5vb3lhbGEuY29tL3BsYXllci9pcGhvbmUvSnBOekJ6TnpyNGNIY0pCWUZKSHY3RGVIQ25xRDdEY0gubTN1OA==
function b64() {
  echo $1 | base64 -D
  echo ""
}

function cdh5
{
local CLEAN_PATH=`/usr/bin/ruby -e 'print ENV["PATH"].split(":").reject{|p| p=~/(hadoop|hive|sqoop)_distros/ }.join(":")'`

export HADOOP_HOME=$OOYALA_REPO_ROOT/vendor/hadoop_distros/current-cdh5
export HIVE_HOME=$OOYALA_REPO_ROOT/vendor/hive_distros/current-cdh5
export SQOOP_HOME=$OOYALA_REPO_ROOT/vendor/sqoop_distros/current-cdh5
export PATH=$HADOOP_HOME/bin:$HIVE_HOME/bin:$SQOOP_HOME/bin:$CLEAN_PATH
}

function cdh3
{
local CLEAN_PATH=`/usr/bin/ruby -e 'print ENV["PATH"].split(":").reject{|p| p=~/(hadoop|hive|sqoop)_distros/ }.join(":")'`

export HADOOP_HOME=$OOYALA_REPO_ROOT/vendor/hadoop_distros/current
export HIVE_HOME=$OOYALA_REPO_ROOT/vendor/hive_distros/current
export SQOOP_HOME=$OOYALA_REPO_ROOT/vendor/sqoop_distros/current
export PATH=$HADOOP_HOME/bin:$HIVE_HOME/bin:$SQOOP_HOME/bin:$CLEAN_PATH
}


###################
# EXPORTS
###################

export OOYALA_CODE_ROOT=$HOME/repos/ooyala
export OOYALA_REPO_ROOT=$HOME/repos

export OO_DEPLOY_DIR=$HOME/.ooyala_credentials

export DELPHI_HOME=$HOME/repos/delphi-reporter

export PATH=$PATH:/usr/local/mysql/bin/:/usr/local/mysql/support-files

export JAVA_HOME=`/usr/libexec/java_home`
export ANT_OPTS="-Xmx960m -XX:MaxPermSize=784m"

export PATH=$HOME/.rbenv/bin:$PATH

export GOPATH=$HOME/go
export PATH=$PATH:~/go/bin

export PATH=~/scala-2.9.2/bin/:~/repos/vendor/sbt:$PATH

export SCALA_HOME=$HOME/scala-2.9.2

export PATH=~/bin:$PATH

export PATH=~/play-2.1.2:$PATH
export PATH=~/spark-0.7.0/bin:$PATH

export CASSANDRA_HOME=$OOYALA_REPO_ROOT/vendor/cassandra_distros/current

export REDIS_HOME=$OOYALA_REPO_ROOT/redis-2.6.14/src

export MYSQL_UNIX_PORT=`mysql_config --socket`

export HADOOP_HOME=$OOYALA_CODE_ROOT/vendor/hadoop_distros/current-cdh5
export PATH="$HADOOP_HOME/bin:$PATH"

export PATH="$PATH:$HOME/repos/jenkins-cli/bin"


###################
# RANDOM
###################

eval "$(rbenv init -)"

SBT_OPTS=-XX:MaxPermSize=512m

HISTFILESIZE=5000

if [ -f $HOME/.git-prompt.sh ]; then
 source $HOME/.git-prompt.sh
fi

# Add current git branch, date/time, and pretty colors to the command prompt
function precmd
{
local JAVA_VERSION=`echo $JAVA_HOME | grep -o "[0-9.]*[0-9]"`
local HADOOP_VERSION=`readlink $HADOOP_HOME | cut -d '-' -f 3-`
local GIT_BRANCH="$(__git_ps1 "(%s)")"
# # Shows a "*" next to the branch name if you have un-staged local changes
# # Shows a "+" next to the branch name if you have staged local changes
# # export GIT_PS1_SHOWDIRTYSTATE=1
# # Shows a "$" next to the branch name if you have stashed changes
# # export GIT_PS1_SHOWSTASHSTATE=1
# # Shows a "%" next to the branch name if you have untracked files
# export GIT_PS1_SHOWUNTRACKEDFILES=1
# # Put it all together
PS1="%{%F{magenta}%}[%D{%a %b %y} %*] %{%F{red}%}`rbenv version-name` %{%f%}- %{%F{blue}%}$JAVA_VERSION %{%F{green}%}$HADOOP_VERSION %{%f%}%n %{%F{red}%}%d %{%F{magenta}%}$GIT_BRANCH
%{%F{green}%}$ %{%f%}"
}


# Makes cd and pushd resolve symlinks to real paths
set -P
