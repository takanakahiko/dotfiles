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

## Claude Code skills

`dotter deploy` のあとに `claude/install.sh` が動き、スキルを入れます。何度実行しても大丈夫です。

- **自分のスキル**は takanakahiko/skills で管理します。作業コピー（`$(ghq root)/github.com/takanakahiko/skills`）の `skills/*` を `~/.claude/skills/` にリンクします。
  - 手元で直すと、そのまま作業コピーの変更になります。コミットして PR を出せば公開されます。
  - 公開先の変更は `install.sh` が `git pull` で取り込みます。作業コピーが main 以外のブランチにいるときと、未コミットの変更があるときは取り込みません。
  - スキルが増えたり消えたりしても、`install.sh` を実行すればリンクが揃います。
- **他の人のスキル**は中身を持たず、`claude/skills.txt` にリポジトリとコミットを書いて固定します。`gh skill install --pin` で入れます。版を上げるときは、コミットを書き換えて `install.sh` を実行します。
- japanese-guard（フック）は、`claude/.claude-plugin/marketplace.json` に置いています。
