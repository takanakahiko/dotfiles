#!/bin/bash -eu

# Migrate from rcm to dotter
# Safe to run multiple times (idempotent)

cd ~/dotfiles

# Remove rcm symlinks (only old-style paths pointing to dotfiles/zshrc etc, not dotfiles/home/)
if command -v rcdn >/dev/null 2>&1; then
  echo "Removing rcm symlinks..."
  rcdn -v || true
fi

# Clean up any remaining old-style symlinks (pointing to dotfiles/ but not dotfiles/home/)
find ~ -maxdepth 1 -type l -lname "*/dotfiles/*" ! -lname "*/dotfiles/home/*" -exec rm -v {} \;
find ~/.config -type l -lname "*/dotfiles/*" ! -lname "*/dotfiles/home/*" -exec rm -v {} \; 2>/dev/null || true

# Remove leftover ~/.rcrc
rm -f ~/.rcrc

# Uninstall rcm if installed
if command -v brew >/dev/null 2>&1 && brew list rcm >/dev/null 2>&1; then
  echo "Uninstalling rcm..."
  brew uninstall rcm
fi

# Install packages (including dotter)
echo "Installing packages..."
brew bundle

# Deploy dotfiles with dotter
echo "Deploying dotfiles with dotter..."
dotter deploy -v --force

echo "Migration complete!"
