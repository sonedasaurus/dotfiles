#!/bin/sh
set -eu

repo_dir=$(cd "$(dirname "$0")" && pwd)
rm -rf "$HOME/.config/nvim"
ln -s "$repo_dir/.config/nvim" "$HOME/.config/nvim"
