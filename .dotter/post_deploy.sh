#!/bin/bash -eu

# ~/.config/mise/config.toml に書いたランタイムを入れる
if command -v mise >/dev/null 2>&1; then
  mise install
fi

# Claude Code のプラグイン（自作のものと、コミットで固定した他の人のもの）を入れる
"$HOME/dotfiles/claude/install.sh"
