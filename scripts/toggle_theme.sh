#!/bin/bash
# filepath: ~/.config/scripts/toggle_theme.sh

CONFIG_DIR="$HOME/.config"
STATE_FILE="$CONFIG_DIR/current_theme"

# Read current state
if [ -f "$STATE_FILE" ]; then
    CURRENT=$(cat "$STATE_FILE")
else
    CURRENT="catppuccin"
fi

# Toggle logic
if [ "$CURRENT" == "catppuccin" ]; then
    NEW="poimandres"
else
    NEW="catppuccin"
fi

echo "$NEW" > "$STATE_FILE"

# 1. Update Tmux symlink
ln -sf "$CONFIG_DIR/tmux/$NEW.conf" "$CONFIG_DIR/tmux/theme.conf"
tmux source-file ~/.tmux.conf > /dev/null 2>&1

# 2. Update Starship symlink
ln -sf "$CONFIG_DIR/starship/$NEW.toml" "$CONFIG_DIR/starship/starship.toml"

# 3. Update Ghostty
# Ghostty config uses "theme = name"
if [ "$NEW" == "catppuccin" ]; then
    sed -i '' 's/^theme = .*/theme = catppuccin-mocha/' "$CONFIG_DIR/ghostty/config"
else
    sed -i '' 's/^theme = .*/theme = poimandres/' "$CONFIG_DIR/ghostty/config"
fi

# 4. Reload Ghostty (Send Cmd+Shift+,)
osascript -e '
tell application "Ghostty"
    activate
    tell application "System Events" to keystroke "," using {command down, shift down}
end tell'

echo "Switched to $NEW"
