# Dotfiles

## Preparation

```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
$ cd ~ && git clone https://github.com/takanakahiko/dotfiles
$ cd dotfiles
$ brew bundle
$ env RCRC=$HOME/dotfiles/rcrc rcup
```

## Follow changes from other machines

```bash
$ rcup
$ brew bundle
$ brew bundle cleanup
```

## Update dotfiles

```bash
$ mkrc ~/.hogehuga
$ brew bundle dump --force
```
