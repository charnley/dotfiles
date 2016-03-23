
alias sunray='ssh -YC sunray'


# Git Shortcuts
alias amend='git commit --amend'
alias gca='git commit -a'
alias gd='git diff'
alias gdc='git diff --cached'
alias gg='git lg'

alias gph='git push'
alias gpl='git pull'

alias gc='git clone'

# Others Shortcuts
alias l='ls -lh'
alias cd.='cd ..'
alias cd..='cd ..'
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
            *.rar)       unrar x $1       ;;
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
