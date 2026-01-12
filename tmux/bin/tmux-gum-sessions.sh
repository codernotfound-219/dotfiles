#!/usr/bin/env bash
set -euo pipefail

gum_bin="${GUM_BIN:-gum}"

pick_session() {
  tmux list-sessions -F '#S' 2>/dev/null | "$gum_bin" filter \
    --placeholder "PICK A SESSION" \
    --prompt "⚡ " \
    --limit 1
}

pick_fallback_session() {
  local current="$1"
  tmux list-sessions -F '#S' 2>/dev/null | grep -Fxv "$current" | head -n 1 || true
}

while true; do
  session="$(pick_session || true)"
  if [[ -z "${session:-}" ]]; then
    exit 0
  fi

  current="$(tmux display-message -p '#S')"

  printf "\nSelected: %s\n" "$session"
  printf "Enter=switch | Ctrl+d=delete | r=rename | Esc=cancel\n"

  key=""
  if read -r -s -n 1 key; then
    :
  else
    # Ctrl+d comes through as EOF (read fails). Treat it as delete.
    key=$'\x04'
  fi

  case "$key" in
    ""|$'\n')
      tmux switch-client -t "$session"
      exit 0
      ;;
    $'\x04') # Ctrl+d
      if "$gum_bin" confirm "Kill session '$session'?" ; then
        if [[ "$session" == "$current" ]]; then
          fallback="$(pick_fallback_session "$current")"
          if [[ -z "${fallback:-}" ]]; then
            printf "Refusing to kill the only active session.\n"
            read -r -n 1 -s
            continue
          fi
          tmux switch-client -t "$fallback"
        fi
        tmux kill-session -t "$session"
      fi
      ;;
    r|R)
      new="$("$gum_bin" input --prompt "New name: " --value "$session" || true)"
      if [[ -n "${new:-}" ]]; then
        tmux rename-session -t "$session" "$new"
      fi
      ;;
    $'\e') # Esc
      exit 0
      ;;
    *)
      # ignore other keys
      ;;
  esac
done
