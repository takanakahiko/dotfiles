#!/bin/bash -eu

# anyenv setup
if command -v anyenv >/dev/null 2>&1; then
  for env in plenv rbenv nodenv jenv; do
    if [ ! -d "$(anyenv root)/envs/$env" ]; then
      anyenv install "$env"
      echo "installed: $env"
    fi
  done

  # anyenv-update plugin
  plugin_dir="$(anyenv root)/plugins/anyenv-update"
  if [ ! -d "$plugin_dir" ]; then
    mkdir -p "$(anyenv root)/plugins"
    git clone https://github.com/znz/anyenv-update.git "$plugin_dir"
    echo "installed: anyenv-update plugin"
  fi
fi
