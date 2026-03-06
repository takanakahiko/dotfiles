# Dotfiles

## Preparation

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
cd ~ && git clone https://github.com/takanakahiko/dotfiles
cd dotfiles
brew bundle
dotter deploy -v --force
```

## Sync changes from other machines

```bash
git pull
dotter deploy -v
brew bundle install --cleanup
```

## Sync changes to other machines

```bash
brew bundle dump --force
git add -A && git commit -m "update" && git push
```

## Add new dotfiles

```bash
cp ~/.vimrc ~/dotfiles/home/.vimrc
dotter deploy -v
```

## Migrate from rcm

If this is first migration from RCM in this machine:

```bash
./migrate-from-rcm.sh
```
