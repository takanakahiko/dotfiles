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

## Claude Code plugins

`dotter deploy` のあとに `claude/install.sh` が動き、プラグインを入れ直します。

- 自作のスキルは takanakahiko/skills で管理します。
- 他の人のプラグインは中身を持たず、`claude/.claude-plugin/marketplace.json` にリポジトリとコミット（`sha`）だけを書いて固定します。版を上げるときは `sha` を書き換えて `claude/install.sh` を実行します。
