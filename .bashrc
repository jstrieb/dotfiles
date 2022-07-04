# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# https://stackoverflow.com/a/19533853
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

alias ll='ls -AlFh'
alias la='ls -A'
alias l='ls -CF'

export VISUAL=vim
export EDITOR="$VISUAL"

function brc () {
  vim ~/.bashrc;
  . ~/.bashrc;
}

# Display the motd if inside tmux
if [ -n "$TMUX" ] && [ -n "$TMUX_PANE" ] && [ "$TMUX_PANE" = "%0" ]; then
  cat /etc/motd
fi

alias tmxu="tmux"
alias sl="ls"

alias webserver="python3 -m http.server 8080 &> /dev/null &"
alias backup-website="wget --mirror --convert-links --adjust-extension --page-requisites --no-parent"
alias latest="ls -rt | tail"

alias ttyd-run="ttyd --readonly --port 6969 tmux new -A -s ttyd /bin/bash &> /dev/null"
alias ttyd-attach="tmux new -A -s ttyd"

alias less="less -X"
