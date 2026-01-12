# zmodload zsh/zprof

#Path to set locale encoding
export LANG="en_US.UTF-8"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# STARSHIP
eval "$(starship init zsh)"
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

# ZOXIDE
eval "$(zoxide init zsh)"

# VS code command for 'code .'
 code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# Opts
setopt HIST_IGNORE_SPACE

# PATHS
export PATH="$PATH:$Home/Flutterdev/flutter/bin"
export PATH="$PATH:/opt/homebrew/opt/bison/bin"
export PATH="$PATH:/opt/homebrew/opt/flex/bin"
export PATH="$PATH:/opt/homebrew/opt/verilator/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:/usr/local/mysql-commercial-9.5.0-macos15-arm64/bin"
export SYSTEMC_HOME="/opt/homebrew/opt/systemc"

# LDFLAGS
export LDFLAGS="-L/opt/homebrew/opt/bison/lib $LDFLAGS"
export LDFLAGS="-L/opt/homebrew/opt/flex/lib $LDFLAGS"
export CFLAGS="-L/opt/homebrew/opt/flex/include $CFLAGS"
export CXXFLAGS="-L/opt/homebrew/opt/flex/include $CXXFLAGS"

# export PATH="$PATH:$HOME/miniforge3/bin/conda"

# brew
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

# MANUAL PLUGINS
source ~/.config/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh-plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.config/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=()

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# TIME-FOR-LOAD
timezsh() {
 shell=${1-$SHELL}
 for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

reload() {
  source ~/.zshrc
}

# YAZI fn
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# ALIASES
# gh
eval "$(gh copilot alias -- zsh)"
alias cs='ghcs'
alias ce='ghce'

# esp-idf
alias get_idf='. $HOME/esp/esp-idf/export.sh'

# CD
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ls='eza --color=always --long --git --no-filesize --no-time --no-user --no-permissions --icons=always'
alias lt='eza --color=always --tree --long --git --no-filesize --no-time --no-user --no-permissions --icons=always'
alias inv='nvim $(find . -maxdepth 2 | fzf --preview="bat --color=always {}")'
alias v='nvim .'
alias icode='code-insiders'

# qof
alias cm="cmatrix -sbu 3 -C cyan"
alias nq='networkquality'
alias lg='lazygit'
alias cl='clear'
alias cls='clear'
alias vim='nvim'
alias vi='nvim'
alias top='btop'
alias htop='btop'
alias toggle='~/.config/scripts/toggle_theme.sh'

# NOTE: DO NOT EVER USE PYENV
# SETTING PYTHON ENV
#
# BUG: enabling the following lines makes zsh mad slow :(
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# eval "$(pyenv init -)" # MAD SLOW: do not enable, use no-rehash
# eval "$(pyenv init --path --no-rehash)"
# eval "$(pyenv virtualenv-init -)" # MAD SLOW: do not enable, use pre-hook
# only on directory change to improve performance
# eval "$(pyenv virtualenv-init - | sed s/precmd/precwd/g)"

# NOTE: 
# COMMENT OUT THE ENTIRE THING. PYTHON IS SHIT SLOW!!!

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#
# __conda_setup="$('$HOME/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
#         . "$HOME/miniforge3/etc/profile.d/conda.sh"
#     else
#         export PATH="$HOME/miniforge3/bin:$PATH"
#     fi
# fi
#
# unset __conda_setup
#
# if [ -f "$HOME/miniforge3/etc/profile.d/mamba.sh" ]; then
#     . "$HOME/miniforge3/etc/profile.d/mamba.sh"
# fi

# <<< conda initialize <<<

# zprof
