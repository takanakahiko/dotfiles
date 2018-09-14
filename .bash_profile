export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew"
eval "$(pyenv virtualenv-init -)"
alias ll='ls -lGaf'

export PATH="$HOME/.cargo/bin:$PATH"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
