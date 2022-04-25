# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export KCODE=u
export AUTOFEATURE=true
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export TERM=screen-256color

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
autoload -U compinit; compinit
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

export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(anyenv init -)"
eval "$(pyenv init --path)"
export GO111MODULE=on
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"


export PATH="/usr/local/opt/gettext/bin:$PATH"
export PATH="$HOME/dev/bin:$PATH"

export PATH=$PATH:$XDG_CONFIG_HOME/yarn/global/node_modules/.bin
export PATH=$PATH:$XDG_CONFIG_HOME/composer/vendor/bin
export PATH=$PATH:$HOME/.cargo/bin
[ -f ~/.zplug/init.zsh ] && source ~/.init.zplug
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
autoload -Uz zmv

# extra function
function google() {
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            str="$str+$i"
        done
        str=`echo $str | sed 's/^\+//'`
        opt='search?num=50&hl=ja&lr=lang_ja'
        opt="${opt}&q=${str}"
    fi
    w3m http://www.google.co.jp/$opt
}

# Setup prompt pure
# https://github.com/sindresorhus/pure/issues/584#issuecomment-989054653
fpath+=/opt/homebrew/share/zsh/site-functions
autoload -U promptinit; promptinit
prompt pure

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters

ssh-add ~/.ssh/id_rsa

export PATH=$PATH:$HOME/dev/flutter/bin

eval "$(direnv hook zsh)"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/takayuki.nakayama/dev/gitlab/test-aws-lambda/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/takayuki.nakayama/dev/gitlab/test-aws-lambda/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/takayuki.nakayama/dev/gitlab/test-aws-lambda/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/takayuki.nakayama/dev/gitlab/test-aws-lambda/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/takayuki.nakayama/dev/gitlab/test-aws-lambda/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/takayuki.nakayama/dev/gitlab/test-aws-lambda/node_modules/tabtab/.completions/slss.zsh
export PATH="/usr/local/opt/opencv@2/bin:$PATH"



export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk-14.0.1.jdk/Contents/Home"

alias g='cd $(ghq root)/$(ghq list | peco)'
alias ll='ls -lGaf'

export PATH="/usr/local/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/usr/local/opt/openjdk/include"

code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

export CLOUDSDK_PYTHON="$(anyenv root)/envs/pyenv/versions/2.7.18/bin/python"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/takayuki.nakayama/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/takayuki.nakayama/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/takayuki.nakayama/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/takayuki.nakayama/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$HOME/.poetry/bin:$PATH"

# https://www.rust-lang.org/learn/get-started
source $HOME/.cargo/env
