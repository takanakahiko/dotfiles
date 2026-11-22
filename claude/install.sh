#!/bin/bash -eu
# Claude Code のプラグインを入れ直す
#   - 他の人のプラグイン: このディレクトリの .claude-plugin/marketplace.json（コミットで固定した参照）
#   - 自分のプラグイン: takanakahiko/skills
# 何度実行してもよい（入っているものは入れ直さない）

if ! command -v claude >/dev/null 2>&1; then
  echo "claude が見つからないので、プラグインの導入をスキップします" >&2
  exit 0
fi

here="$(cd "$(dirname "$0")" && pwd)"

claude plugin marketplace add "$here" >/dev/null
claude plugin marketplace add takanakahiko/skills >/dev/null
# マーケットプレイスの内容を読み直す（固定した参照の書き換えや、skills の新しいコミットを拾う）
claude plugin marketplace update dotfiles-deps >/dev/null
claude plugin marketplace update takanakahiko >/dev/null

installed="$(claude plugin list --json | jq -r '.[].id')"

install() {
  if grep -qxF "$1" <<<"$installed"; then
    # 入っているものは、マーケットプレイスの内容（固定したコミット）に合わせる
    claude plugin update "$1" >/dev/null
  else
    claude plugin install "$1" -y >/dev/null
  fi
  echo "ok: $1"
}

# 他の人のプラグイン（すべて入れる）
for name in $(jq -r '.plugins[].name' "$here/.claude-plugin/marketplace.json"); do
  install "$name@dotfiles-deps"
done

# 自分のプラグイン（使うものを選ぶ）
for name in retro-blog review-branch-diff 3d-print-modeling bambu-studio-3mf; do
  install "$name@takanakahiko"
done
