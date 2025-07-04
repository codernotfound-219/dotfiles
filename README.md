# Dotfiles

Personal configuration files for macOS development environment.

## 🖥️ Terminal

### **Ghostty**
Modern, fast GPU-accelerated terminal emulator
- **Theme**: Catppuccin Mocha
- **Font**: Lilex Nerd Font (17pt)
- **Features**: 90% background opacity, hidden titlebar, custom padding
- **Config**: [`ghostty/config`](ghostty/config)

## 💻 Editor

### **Neovim**
Highly customizable text editor with extensive plugin ecosystem
- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Theme**: Catppuccin Mocha with transparency
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
- **Config**: [`starship/starship.toml`](starship/starship.toml)

## 🔧 Terminal Multiplexer

### **Tmux**
Terminal multiplexer for managing multiple sessions
- **Prefix**: `Ctrl+S` (instead of default `Ctrl+B`)
- **Features**:
  - Vim-style navigation
  - Session management with sesh
  - Plugin ecosystem (TPM, Catppuccin theme)
  - Vim-tmux navigator integration
- **Config**: [`tmux/.tmux.conf`](tmux/.tmux.conf)

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

- **File Manager**: Yazi with git integration and catppuccin theme
- **System Monitor**: btop
- **Git TUI**: lazygit
- **Fuzzy Finder**: fzf integration
- **Directory Jumper**: zoxide

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

3. Install dependencies:
   ```zsh
   # Install Homebrew if not already installed
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   
   # Install essential tools
   brew install neovim tmux starship zoxide yazi eza bat fzf lazygit btop gh
   ```

4. Install Tmux Plugin Manager:
   ```zsh
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

5. Reload configurations:
   ```zsh
   source ~/.zshrc
   tmux source ~/.tmux.conf
   ```

## 🎯 Key Features

- **Consistent Theming**: Catppuccin Mocha across all applications
- **Vim-style Navigation**: Consistent keybindings across terminal, editor, and multiplexer
- **Git Integration**: Visual git status in file managers and prompts
- **Performance Optimized**: Fast shell startup and responsive tools
- **Modern Tools**: Latest generation of CLI tools (eza, bat, yazi, etc.)

## 🔧 Customization

Each tool's configuration is modular and can be customized independently:

- **Neovim**: Modify plugins in [`nvim/lua/plugins/`](nvim/lua/plugins/)
- **Tmux**: Edit [`tmux/.tmux.conf`](tmux/.tmux.conf)
- **Zsh**: Update [`zsh/.zshrc`](zsh/.zshrc)
- **Starship**: Customize [`starship/starship.toml`](starship/starship.toml)

## 📝 Notes

- Some paths may need adjustment for your system
- The debug configuration contains a personal path that should be updated
- Plugins and tools may require additional setup on first run