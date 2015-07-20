if [ -f ~/.shrc_common ]; then
  . ~/.shrc_common
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
PS1="%{%F{magenta}%}[%D{%a %b %y} %*] %{%f%}- %{%F{blue}%}$JAVA_VERSION %{%F{green}%}$HADOOP_VERSION %{%f%}%n %{%F{red}%}%d %{%F{magenta}%}$GIT_BRANCH
%{%F{green}%}$ %{%f%}"
}