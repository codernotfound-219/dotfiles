# Dotfiles

Personal configuration files for macOS development environment.

## 🎨 Themes

### **Dual Theme System**
- **Themes**:
  - **Catppuccin Mocha**: High-contrast, vibrant pastel theme.
  - **Poimandres**: Minimal, deep sea/dark blue theme (`#1b1e28` background).
- **Toggle Mechanism**: Instantly switch Ghostty, Tmux, Neovim, and Starship via a single command.
- **Command**: `toggle` (alias for `~/.config/scripts/toggle_theme.sh`).

## 🖥️ Terminal

### **Ghostty**
Modern, fast GPU-accelerated terminal emulator
- **Themes**: Catppuccin Mocha / Poimandres (Custom Port)
- **Font**: Lilex Nerd Font (17pt)
- **Features**: 90% background opacity, hidden titlebar, custom padding
- **Config**: [`ghostty/config`](ghostty/config)

## 💻 Editor

### **Neovim**
Highly customizable text editor with extensive plugin ecosystem
- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Themes**: Catppuccin Mocha & Poimandres (Auto-detects from state file)
- **Key Features**:
  - LSP support (Rust, C++, TypeScript, Lua)
  - Autocompletion with nvim-cmp
  - File navigation with Telescope & Yazi
  - Git integration with Gitsigns
  - Tmux navigation integration
  - Debug support with nvim-dap
- **Config**: [`nvim/`](nvim/)

## 🎨 Prompt

### **Starship**
Fast, customizable shell prompt
- **Layout**: Minimal left prompt with git info, detailed right prompt
- **Features**: Command duration, git status, language-specific indicators
- **Config**: [`starship/starship.toml`](starship/starship.toml) (Symlinked to active theme)

## 🔧 Terminal Multiplexer

### **Tmux**
Terminal multiplexer for managing multiple sessions
- **Prefix**: `Ctrl+S` (instead of default `Ctrl+B`)
- **Structure**:
  - Main config: `tmux/.tmux.conf`
  - Theme configs: `tmux/catppuccin.conf`, `tmux/poimandres.conf`
- **Features**:
  - Minimal top bar (Session Name | Windows | Time)
  - Zoom indicator (Pink/Peach depending on theme)
  - Vim-style navigation
  - Session management with *sesh* (Theme-aware gum popup)
  - Vim-tmux navigator integration

## 🐚 Shell

### **Zsh**
Enhanced shell with plugins and custom configuration
- **Plugins**:
  - `zsh-autosuggestions`: Command suggestions
  - `zsh-syntax-highlighting`: Syntax highlighting
  - `zsh-autocomplete`: Tab completion
- **Tools Integration**:
  - Starship prompt
  - Zoxide for smart directory jumping
  - Yazi file manager integration
  - GitHub Copilot CLI aliases
- **Config**: [`zsh/.zshrc`](zsh/.zshrc)

## 🛠️ Additional Tools

- **File Manager**: Yazi
- **System Monitor**: btop
- **Git TUI**: lazygit
- **Fuzzy Finder**: fzf integration
- **Directory Jumper**: zoxide
- **Note-Taking**: Obsidian

## 📦 Prerequisites

Before installing, ensure you have the following dependencies. Using [Homebrew](https://brew.sh/) is recommended for macOS.

### **Core**
- **[Neovim](https://neovim.io/)** (v0.9+): `brew install neovim`
- **[Tmux](https://github.com/tmux/tmux)** (v3.2+): `brew install tmux`
- **[Ghostty](https://ghostty.org/)** (Recommended Terminal): `brew install ghostty`

### **CLI Utilities**
- **[Starship](https://starship.rs/)**: `brew install starship`
- **[Zoxide](https://github.com/ajeetdsouza/zoxide)**: `brew install zoxide`
- **[Fzf](https://github.com/junegunn/fzf)**: `brew install fzf`
- **[Bat](https://github.com/sharkdp/bat)**: `brew install bat`
- **[Yazi](https://github.com/sxyazi/yazi)**: `brew install yazi`
- **[Lazygit](https://github.com/jesseduffield/lazygit)**: `brew install lazygit`
- **[Btop](https://github.com/aristocratos/btop)**: `brew install btop`
- **[Ripgrep](https://github.com/BurntSushi/ripgrep)**: `brew install ripgrep` (Required for Telescope)
- **[Fd](https://github.com/sharkdp/fd)**: `brew install fd` (Required for Telescope)

### **Session Management**
- **[Sesh](https://github.com/joshmedeski/sesh)**: `brew install joshmedeski/sesh/sesh`
- **[Gum](https://github.com/charmbracelet/gum)**: `brew install gum`

### **Fonts**
- **[Nerd Fonts](https://www.nerdfonts.com/)**: Required for icons.
  - Recommended: **Lilex Nerd Font** or **JetBrains Mono Nerd Font**.

## 📁 Installation

1. Clone this repository to `~/.config`:
   ```zsh
   git clone https://github.com/codernotfound-219/dotfiles.git ~/.config
   ```

2. Create necessary symlinks:
    ```zsh
    ln -sf ~/.config/tmux/.tmux.conf ~/.tmux.conf
    ln -sf ~/.config/zsh/.zshrc ~/.zshrc
   ```

3. Initialize Theme System:
    ```zsh
    chmod +x ~/.config/scripts/toggle_theme.sh
    toggle
   ```

## 🎯 Key Features
- **Dynamic Theming**: Instant toggle between vibrant and minimal aesthetics.
- **Consistent UI**: All tools (Tmux, Neovim, Terminal, Prompt) stay in sync.
- **Vim-style Navigation**: Consistent keybindings across terminal, editor, and multiplexer.
- **Performance Optimized**: Fast shell startup and responsive tools.

## 🔧 Customization
- **Tmux Themes**: Edit tmux/poimandres.conf or tmux/catppuccin.conf.
- **Toggle Logic**: Modify scripts/toggle_theme.sh.
