#!/usr/bin/env bash
set -euo pipefail

SELF="${0}"

list_sessions() {
  local current
  current="$(tmux display-message -p '#S')"
  tmux list-sessions -F '#S' 2>/dev/null | awk -v c="$current" '
    {
      mark = ($0 == c) ? "•" : " "
      printf "%s\t%s\n", mark, $0
    }'
}

kill_session() {
  local target="${1:?}"
  local current count fallback

  count="$(tmux list-sessions 2>/dev/null | wc -l | tr -d ' ')"
  if [[ "${count}" -le 1 ]]; then
    printf "Refusing to kill the only session.\n" > /dev/tty
    read -r -n 1 -s < /dev/tty || true
    return 0
  fi

  printf "Kill session '%s'? [y/N] " "$target" > /dev/tty
  local ans=""
  read -r ans < /dev/tty || true
  [[ "$ans" =~ ^[yY] ]] || return 0

  current="$(tmux display-message -p '#S')"
  if [[ "$target" == "$current" ]]; then
    fallback="$(tmux list-sessions -F '#S' | grep -Fxv "$target" | head -n 1 || true)"
    [[ -n "${fallback:-}" ]] && tmux switch-client -t "$fallback"
  fi

  tmux kill-session -t "$target"
}

rename_session() {
  local target="${1:?}"
  printf "Rename '%s' to: " "$target" > /dev/tty
  local new=""
  read -r new < /dev/tty || true
  [[ -n "${new:-}" ]] || return 0
  tmux rename-session -t "$target" "$new"
}

case "${1-}" in
  --list) list_sessions; exit 0 ;;
  --kill) shift; kill_session "${1:?}"; exit 0 ;;
  --rename) shift; rename_session "${1:?}"; exit 0 ;;
esac

command -v fzf >/dev/null 2>&1 || {
  printf "fzf not found in PATH.\n" > /dev/tty
  read -r -n 1 -s < /dev/tty || true
  exit 1
}

"${SELF}" --list | fzf \
  --no-multi \
  --delimiter=$'\t' \
  --with-nth=2 \
  --prompt='⚡ session> ' \
  --header='Enter=switch  Ctrl+d=delete  Ctrl+r=rename  Esc=close' \
  --bind "enter:execute(tmux switch-client -t {2})+abort" \
  --bind "ctrl-d:execute(${SELF} --kill {2})+reload(${SELF} --list)" \
  --bind "ctrl-r:execute(${SELF} --rename {2})+reload(${SELF} --list)"
