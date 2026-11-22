#!/bin/bash -eu
# Claude Code のスキルを入れる。何度実行してもよい
#   - 自分のスキル: takanakahiko/skills の作業コピーを ~/.claude/skills/ にリンクする
#     （手元で直すとそのままリポジトリの変更になり、公開先の変更は git pull で入る）
#   - 他の人のスキル: claude/skills.txt に書いたコミットで固定して gh skill で入れる

here="$(cd "$(dirname "$0")" && pwd)"
dest="$HOME/.claude/skills"
mkdir -p "$dest"

# --- 自分のスキル ---
repo="$(ghq root)/github.com/takanakahiko/skills"
[ -d "$repo" ] || ghq get takanakahiko/skills

# main にいて手元に変更がないときだけ公開先の変更を取り込む（作業中のものは壊さない）
if [ "$(git -C "$repo" branch --show-current)" = main ] && [ -z "$(git -C "$repo" status --porcelain)" ]; then
  git -C "$repo" pull -q --ff-only
else
  echo "skip pull: $repo は main 以外のブランチか、未コミットの変更があります" >&2
fi

# skills/ にあるものをすべてリンクする（増えたスキルもここで入る）
for dir in "$repo"/skills/*/; do
  [ -f "$dir/SKILL.md" ] || continue
  name="$(basename "$dir")"
  link="$dest/$name"
  if [ -e "$link" ] && [ ! -L "$link" ]; then
    echo "skip: $link はリンクではないので触りません" >&2
    continue
  fi
  ln -sfn "${dir%/}" "$link"
  echo "link: $name"
done

# リポジトリから消えたスキルのリンクを外す
for link in "$dest"/*; do
  [ -L "$link" ] || continue
  case "$(readlink "$link")" in
    "$repo"/skills/*) [ -e "$link" ] || { rm "$link"; echo "unlink: $(basename "$link")"; } ;;
  esac
done

# --- 他の人のスキル ---
grep -v '^\s*\(#\|$\)' "$here/skills.txt" | while read -r src name sha; do
  if grep -qs "github-pinned: $sha" "$dest/$name/SKILL.md"; then
    echo "ok: $name ($src@${sha:0:7})"
    continue
  fi
  # 出力が長いので、失敗したときだけ表示する
  if ! out="$(gh skill install "$src" "$name" --pin "$sha" --agent claude-code --scope user --force 2>&1)"; then
    echo "$out" >&2
    exit 1
  fi
  echo "install: $name ($src@${sha:0:7})"
done
