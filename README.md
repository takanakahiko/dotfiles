# Dotfiles

## Preparation

```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
$ cd ~ && git clone https://github.com/takanakahiko/dotfiles
$ cd dotfiles
$ brew bundle
$ dotter deploy -v --force
```

## Follow changes from other machines

```bash
$ git pull
$ dotter deploy -v
$ brew bundle
$ brew bundle cleanup
```

## Update dotfiles

```bash
# home/ ディレクトリ内のファイルを直接編集する
# シンボリックリンク経由でリポジトリ側も自動的に更新される
$ brew bundle dump --force
```

## Add new dotfiles

```bash
# 管理したいファイルを home/ に配置して deploy する
$ cp ~/.vimrc ~/dotfiles/home/.vimrc
$ dotter deploy -v
```
