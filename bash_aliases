
# Set host
alias sunray='ssh -YC sunray'

# Set standard editor
export EDITOR=vi

# Git Shortcuts
alias amend='git commit --amend'
alias gca='git commit -a'
alias gd='git diff'
alias gdc='git diff --cached'
alias gg='git lg'

alias gs='git status -s'
alias gph='git push'
alias gpl='git pull --rebase'

alias gc='git clone'

# tmux shortcuts
alias tm='tmux -2'
alias tml='tmux ls'
alias tmk='tmux kill-session -t $1'
alias tma='tmux -2 attach -t $1'


# Others Shortcuts
alias ls='ls --color'
alias l='ls -lh'
alias cd.='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias u='cd ..'
alias v='vim -p'
alias vi='vim -p'

# Functions
function take {
  mkdir $1
  cd $1
}

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

