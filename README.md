# Dotfiles

## Preparation

```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
$ brew install rcm
$ cd ~ && git clone https://github.com/takanakahiko/dotfiles
$ env RCRC=$HOME/dotfiles/rcrc rcup
```

## Follow changes from other machines

```bash
$ rcup
$ brew bundle cleanup
```

## Update dotfiles

```bash
$ mkrc ~/.hogehuga
$ brew bundle dump --force
```
