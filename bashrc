
# Preserve bash history in multiple terminal windows
export HISTCONTROL=ignoredups:erasedups:ignorespace  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# all my aliases
if test -f ~/.bash_aliases; then . ~/.bash_aliases; fi

# bash completion
if test -f /etc/bash_completion; then . /etc/bash_completion; fi
if test -f /etc/bash_completion.d/tma; then . /etc/bash_completion.d/tma; fi

# Extend $PATH envirument
if test -d "/opt/bin"; then PATH="/opt/bin:$PATH"; fi
if test -d "/opt/sbin"; then PATH="/opt/sbin:$PATH"; fi
if test -d "$HOME/bin"; then PATH="$HOME/bin:$PATH"; fi

# pip local
if test -d "$HOME/.local/bin"; then PATH="$HOME/.local/bin:$PATH"; fi

# I would like to have colours in my terminal
if test $TERM == "xterm"; then export TERM=xterm-256color; fi


# PS1
#
# 0;30m   Black
# 0;31m   Red
# 0;32m   Green
# 0;33m   Yellow
# 0;34m   Blue
# 0;35m   Purple
# 0;36m   Cyan
# 0;37m   White

# http://mediadoneright.com/content/ultimate-git-ps1-bash-prompt

#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Background
# On_Black="\[\033[40m\]"       # Black
# On_Red="\[\033[41m\]"         # Red
# On_Green="\[\033[42m\]"       # Green
# On_Yellow="\[\033[43m\]"      # Yellow
# On_Blue="\[\033[44m\]"        # Blue
# On_Purple="\[\033[45m\]"      # Purple
# On_Cyan="\[\033[46m\]"        # Cyan
# On_White="\[\033[47m\]"       # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

# export PS1="$Blue\h$Color_Off $Cyan\W$Color_Off"

case $HOSTNAME in
    sunray )
        export PS1="$Red\h$Color_Off $Cyan\W$Color_Off";;
    london )
        export PS1="$Black\h$Color_Off $Cyan\W$Color_Off";;
    macragge )
        export PS1="$Black\h$Color_Off $Cyan\W$Color_Off";;
    fend0[1-5].cluster )
        export PS1="$Yellow\h$Color_Off $Cyan\W$Color_Off"
        export PS1NOGIT="True";;
    tutu )
        export PS1="$Blue\h $Cyan\W$Color_Off";;
    * )
        export PS1="$Blue\h$Color_Off $Cyan\W$Color_Off";;
esac


if [ -z "$PS1NOGIT" ]
then
export PS1="$PS1"'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$Green'"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$Red'"$(__git_ps1 " {%s}"); \
  fi)"; \
fi)'

fi

export PS1=$PS1"$Color_Off \$ "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# fuzzy search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# intel

if [ $HOSTNAME = "sunray" ]; then
    export INTEL_LICENSE_FILE=/home/charnley/intel/licenses/l_FR4Z3C6V.lic
    source /home/charnley/intel/bin/compilervars.sh intel64
fi

# if [ $HOSTNAME = "anton" ]; then
#     export INTEL_LICENSE_FILE=/home/charnley/intel/licenses/NCOM_L___2HWS-V94RP65L_1.lic
#     source /home/charnley/intel/bin/compilervars.sh intel64
# fi

if [ $HOSTNAME = "kraken" ]; then
    # intel
    export INTEL_LICENSE_FILE=/opt/intel/composer_xe_2013.1.117/licenses/l_PZD5J4XH.lic
    source /opt/intel/composer_xe_2013.1.117/bin/compilervars.sh intel64
fi

