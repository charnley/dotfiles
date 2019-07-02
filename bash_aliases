
# Set host
alias sunray='ssh -YC sunray'

# sunray specific commands
if [ $HOSTNAME = "sunray" ]; then
    alias sun_idle='sinfo | grep idle'
    alias sun_busy='sinfo | grep alloc; sinfo | grep mix'

    alias q='squeue -u $USER'
    alias ql='squeue | grep $USER | wc -l'

    # http://slurm.schedmd.com/squeue.html
    alias sq='squeue -o "%.10i %.9P %.8u %.10j %.12M %.5D %.4C %R"'
fi

# Set standard editor
export EDITOR=vi

# Git Shortcuts
alias gco='git commit'
alias gca='git commit -a'
alias gad='git add .'
alias gamend='git commit --amend'

alias gd='git diff --color-words'
alias gdc='git diff --cached'
alias gg='git lg'

alias gs='git status -s'
alias gph='git push'
alias gpl='git pull --rebase'

alias ggl='fzf_log'


function gitclone {

    url=$1
    out=$2

    if [[ $url != *"@"* && $url != *"http"* ]]
    then
        git clone git@github.com:$url $out
    else
        git clone $1 $out
    fi

}


fzf_log() {
  hash=$(git log --color=always --format="%h%d %an %ae %s %cr" "$@" | fzf | awk '{print $1}')
  echo -n $hash | xclip -sel clip
  git show $hash --color-words
}

# https://junegunn.kr/2016/07/fzf-git
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

# Will return non-zero status if the current directory is not managed by git
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}


fzf-down() {
  fzf --height 50% "$@" --border
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}


# alias gc='git clone'
alias gc='gitclone' # from bin

# tmux shortcuts
alias tm='tmux'
alias tma='tmux attach -t $1'
alias tml='tmux ls'
alias tmk='tmux kill-session -t $1'
alias tmg='tmux new -s $(basename $(pwd))'

# NOTES
# function tm {
#   [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
#   if [ $1 ]; then
#      tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
#   fi
#   session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
# }

# tmux clean. Kill all integer tmux sessions
alias tmclean='tmux ls -F "#{session_name}" | while read -r line; do if [[ $line =~ ^-?[0-9]+$  ]]; then tmux kill-session -t $line; fi; done'

# Calendar
alias today='gcalcli agenda now tomorrow'
alias week='gcalcli agenda now'
alias todo='gcalcli agenda now'
alias month='gcalcli calm'

# Others Shortcuts
alias ls='ls --color'
alias l='ls -lh'

alias cd.='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias b='cd ..'

alias v='vim -p'
alias e='vim -p'
alias vi='vim -p'

# easy rsync
alias rs='rsync -azvh --progress'

# download a song easy
alias youtube-audio='youtube-dl --extract-audio --audio-format best'

# open a new terminal
alias x='rxvt &'

# spotify
alias spotplay="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
alias spotnext="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"
alias spotprev="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"
alias spotstop="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop"

# Copy vim out to xclip
alias xp='cat ~/.vbuf | xclip -sel clip'

# Get the last output
# makes vim crash
# PROMPT_COMMAND='LAST="`cat /tmp/x`"; exec >/dev/tty; exec > >(tee /tmp/x)'

# Functions
function take {
  mkdir $1
  cd $1
}

# Can't remmeber all the different extraction commands
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1 ;;
            *.tar.gz)    tar xvzf $1 ;;
            *.bz2)       bunzip2 $1 ;;
            *.rar)       unrar x $1 ;;
#            *.gz)        gunzip $1 ;;
            *.gz)        tar xvf $1 ;;
            *.tar)       tar xvf $1 ;;
            *.tbz2)      tar xvjf $1 ;;
            *.tgz)       tar xvzf $1 ;;
            *.zst)       tar -I zstd xvzf $1 ;;
            *.zip)       unzip $1 ;;
            *.Z)         uncompress $1 ;;
            *.7z)        7z x $1 ;;
            *.tar.*)     tar xvf $1 ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

how_in()
{
  where="$1"; shift
  IFS=+ curl "https://cht.sh/$where/ $*"
}


# fun
alias emoji_shrug='echo -n "¯\_(ツ)_/¯" | xclip -selection clipboard'
alias emoji_run='echo -n "ᕕ( ᐛ )ᕗ" | xclip -selection clipboard'

alias myip='echo $(curl -s https://api.ipify.org)'


