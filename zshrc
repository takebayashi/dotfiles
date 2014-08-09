# Environment Variables
export PATH=$HOME/local/bin:$PATH
export LANG=ja_JP.UTF-8
if [ $TMUX ]; then
  export TERM=screen-256color
else
  export TERM=xterm-256color
fi

# Options
setopt auto_pushd
setopt hist_ignore_dups
setopt auto_param_slash
setopt auto_list
setopt correct

# Completions
autoload -Uz compinit
compinit

# Key Bindings
bindkey -v

# Prompt
autoload colors
colors
PROMPT="[%{${fg[magenta]}%}${HOSTNAME}:%~%{${reset_color}%}] %{${fg[yellow]}%}%%%{${reset_color}%} "
PROMPT2="%{${fg[yellow]}%}>%{${reset_color}%} "
SPROMPT="Do you mean %{${fg[red]}%}%r%{${reset_color}%}? [nyae] > "
setopt transient_rprompt

# History
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey ^P history-beginning-search-backward-end
bindkey ^N history-beginning-search-forward-end
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

## ====================

function peco-select-history() {
  local tac
  if which tac > /dev/null; then
      tac="tac"
  else
      tac="tail -r"
  fi
  BUFFER=$(${=tac} $HISTFILE | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-select-directory() {
  local current_buffer=$BUFFER
  local selected_dir="$(find . -type d ! -path "*/.*"| peco)"
  if [ -d "$selected_dir" ]; then
    BUFFER="${current_buffer} \"${selected_dir}\""
    CURSOR=$#BUFFER
  fi
  zle clear-screen
}
zle -N peco-select-directory
bindkey '^a^d' peco-select-directory

function peco-select-file() {
  local current_buffer=$BUFFER
  local selected_file="$(find . -type f ! -path "*/.*"| peco)"
  if [ -f "$selected_file" ]; then
    BUFFER="${current_buffer} \"${selected_file}\""
    CURSOR=$#BUFFER
  fi
  zle clear-screen
}
zle -N peco-select-file
bindkey '^a^f' peco-select-file

## ====================

# Scala
export SCALA_HOME=$HOME/opt/scala-current
export PATH=$SCALA_HOME/bin:$PATH
export PATH=$HOME/opt/sbt-current/bin:$PATH
