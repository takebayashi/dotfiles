autoload -Uz add-zsh-hook

# Environment Variables
export PATH=$HOME/local/bin:$PATH
export LANG=ja_JP.UTF-8
if [ $TMUX ]; then
  export TERM=screen-256color
else
  export TERM=xterm-256color
fi
[[ -z "$HOSTNAME" ]] && export HOSTNAME=$(hostname)

# Window Titles
function winti_preexec() {
  cmd=(${(s: :)${1}})
  echo -ne "\ek$(echo $HOSTNAME | cut -d . -f 1):$cmd[1]\e\\"
}
add-zsh-hook preexec winti_preexec

function winti_precmd() {
  echo -ne "\ek$(echo $HOSTNAME | cut -d . -f 1)\e\\"
}
add-zsh-hook precmd winti_precmd

# Options
setopt auto_pushd
setopt hist_ignore_dups
setopt auto_param_slash
setopt auto_list
setopt correct

# Completions
if [ -d /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi
autoload -Uz compinit
compinit -u

# Key Bindings
bindkey -v

# Aliases
alias tmux='tmux -2'

# Prompt
autoload -Uz vcs_info
autoload -Uz colors
colors
function prompt_precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd prompt_precmd
PROMPT_STATUS_OK=$'\U1F604'
PROMPT_STATUS_WARN=$'\U1F621'
PROMPT="[%{${fg[magenta]}%}${HOSTNAME}%{${reset_color}%}:%{${fg[cyan]}%}%~%{${reset_color}%}] %(?.%F{yellow}%%%f.%F{red}%%%f) "
PROMPT2="%{${fg[yellow]}%}>%{${reset_color}%} "
SPROMPT="Do you mean %{${fg[red]}%}%r%{${reset_color}%}? [nyae] > "
RPROMPT="%1(v|%F{green}%1v%f|)"
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

# Go
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH
function peco-select-ghq-repository() {
  local current_buffer=$BUFFER
  local selected_repo="$(ghq list --full-path | peco)"
  if [ -d "$selected_repo" ]; then
    BUFFER="${current_buffer} \"${selected_repo}\""
    CURSOR=$#BUFFER
  fi
  zle clear-screen
}
zle -N peco-select-ghq-repository
bindkey '^a^g' peco-select-ghq-repository

# Ruby
export PATH=$HOME/.rbenv/bin:$PATH
if which rbenv > /dev/null; then
  eval "$(rbenv init - --no-rehash zsh)"
fi

## ====================

for RC in $(ls $HOME/.zshrc* | grep "^$HOME/\.zshrc\."); do
  . $RC
done
