if [ -f ~/.shrc_common ]; then
  . ~/.shrc_common
fi

HISTFILESIZE=5000

# Add current git branch, date/time, and pretty colors to the command prompt
function prompt_command
{
local WHITE="\[\033[1;37m\]"
local GREEN="\[\033[0;32m\]"
local CYAN="\[\033[0;36m\]"
local GRAY="\[\033[0;37m\]"
local BLUE="\[\033[0;34m\]"
local BLACK="\[\033[0;30m\]"
local PURPLE="\[\033[0;35m\]"
local RED="\[\033[0;31m\]"
local JAVA_VERSION=`echo $JAVA_HOME | grep -o "[0-9.]*[0-9]"`
local HADOOP_VERSION=`readlink $HADOOP_HOME | cut -d '-' -f 3-`
# Shows a "*" next to the branch name if you have un-staged local changes
# Shows a "+" next to the branch name if you have staged local changes
# export GIT_PS1_SHOWDIRTYSTATE=1
# Shows a "$" next to the branch name if you have stashed changes
# export GIT_PS1_SHOWSTASHSTATE=1
# Shows a "%" next to the branch name if you have untracked files
# export GIT_PS1_SHOWUNTRACKEDFILES=1
# Put it all together
export PS1="${PURPLE}[\d \t] ${BLUE}${JAVA_VERSION} ${GREEN}${HADOOP_VERSION} ${WHITE}\u ${RED}\w\n${GREEN}\$${WHITE} "
}
export PROMPT_COMMAND=prompt_command
