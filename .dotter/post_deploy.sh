#!/bin/bash -eu

# ~/.config/mise/config.toml に書いたランタイムを入れる
if command -v mise >/dev/null 2>&1; then
  mise install
fi
