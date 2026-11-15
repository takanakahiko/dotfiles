# Add deno completions to search path
if [[ ":$FPATH:" != *":$HOME/completions:"* ]]; then export FPATH="$HOME/completions:$FPATH"; fi
# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

bindkey -e

setopt no_beep
setopt auto_cd
setopt auto_pushd
#setopt correct
setopt magic_equal_subst
setopt prompt_subst
setopt notify
setopt equals

### Complement ###
setopt auto_list                     # 補完候補を一覧で表示する(d)
setopt auto_menu                     # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed
setopt list_types
bindkey "^[[Z" reverse-menu-complete # Shift-Tabで補完候補を逆順する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

### Glob ###
setopt extended_glob
unsetopt caseglob

### History ###
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history
setopt hist_ignore_dups
setopt share_history
setopt hist_reduce_blanks
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
function history-all { history -E 1 }

# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
autoload -Uz colors; colors
tmp_prompt="%{${fg[cyan]}%}%n[%c] %{${reset_color}%}"
# if root user
[ ${UID} -eq 0 ] && tmp_prompt="%B%U${tmp_prompt}%u%b"
PROMPT=$tmp_prompt
# if ssh
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"

# ------------------------------
# Other Settings
# ------------------------------
### path ###
has() {
  type "$1" > /dev/null 2>&1
}

case "${OSTYPE}" in
  darwin*|linux-gnu)
    export PATH=./vendor/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
  ;;
esac

# Setup HomeBrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# 補完の初期化は fpath を揃えたあとにここで 1 回だけ行う（後続の gcloud / wt などが compdef を使う）
fpath=($HOME/.docker/completions /opt/homebrew/share/zsh/site-functions $fpath)
autoload -Uz compinit; compinit

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

export PATH=$PATH:$XDG_CONFIG_HOME/yarn/global/node_modules/.bin

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
autoload -Uz zmv

# Setup prompt pure
# https://github.com/sindresorhus/pure/issues/584#issuecomment-989054653
autoload -U promptinit; promptinit
prompt pure

eval "$(direnv hook zsh)"

alias g='cd $(ghq root)/$(ghq list | peco)'
alias ll='ls -lGaf'

# https://www.rust-lang.org/learn/get-started
source $HOME/.cargo/env

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Java は temurin cask の JDK を使う。旧 asdf が残した JAVA_HOME=/usr を引き継ぐと
# /usr/bin/java が自分自身を呼び続けて固まるので、毎回ここで設定し直す
if JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)"; then export JAVA_HOME; else unset JAVA_HOME; fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

eval $(thefuck --alias)

. "$HOME/.local/bin/env"
. "$HOME/.deno/env"

# if [ -n "$SSH_CONNECTION" ] && [ -z "$KEYCHAIN_UNLOCKED" ]; then
#   security unlock-keychain ~/Library/Keychains/login.keychain-db
#   export KEYCHAIN_UNLOCKED=true
# fi

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
alias wsc='wt switch --create --execute=claude'
export PATH="$HOME/.local/bin:$PATH"

# mise (runtime version manager)
eval "$(mise activate zsh)"
