#!/bin/sh
set -eu

repo_dir=$(cd "$(dirname "$0")" && pwd)

link_item() {
  source=$1
  target=$2

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    printf '%s is already linked.\n' "$target"
    return
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    printf 'Replace existing %s? [y/N] ' "$target"
    if ! read -r answer; then
      echo "Aborted."
      exit 1
    fi

    case "$answer" in
      [yY] | [yY][eE][sS])
        rm -rf -- "$target"
        ;;
      *)
        echo "Aborted."
        exit 1
        ;;
    esac
  fi

  mkdir -p "$(dirname "$target")"
  ln -s "$source" "$target"
}

link_item "$repo_dir/.config/nvim" "$HOME/.config/nvim"
link_item "$repo_dir/.tmux.conf" "$HOME/.tmux.conf"

for source in "$repo_dir"/.codex/*; do
  [ -e "$source" ] || [ -L "$source" ] || continue
  link_item "$source" "$HOME/.codex/${source##*/}"
done
